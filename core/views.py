from django.shortcuts import render,redirect,get_object_or_404
from django.db import connection, DatabaseError
from core.models import *
from django.contrib.auth.hashers import make_password, check_password
from django.contrib import messages
from datetime import date, datetime
import uuid
from decimal import Decimal

# Create your views here.
def home(request):
    top_destinazioni = VistaTopDestinazioni.objects.all()[:4]
    alloggi_top = VistaClassificaAlloggi.objects.all()[:3]

    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT c.id_citta, c.nome, c.nazione,
                   IFNULL((SELECT COUNT(*) FROM alloggio a WHERE a.id_citta = c.id_citta),0) as numero_alloggi
            FROM citta c
            ORDER BY c.nome
        """)
        citta_objs = [
            {"id_citta": row[0], "nome": row[1], "nazione": row[2], "numero_alloggi": row[3]}
            for row in cursor.fetchall()
        ]

    # Lista semplice dei nomi delle città per il JS
    citta_list = [c['nome'] for c in citta_objs]

    context = {
        "top_destinazioni": top_destinazioni,
        "alloggi_top": alloggi_top,
        "citta_objs": citta_objs,
        "citta_list": citta_list,  # <-- aggiunta
    }
    return render(request, 'home.html', context)

def lista_alloggi(request):
    # Recupera i parametri di filtro dalla request
    tipo_alloggio = request.GET.get('tipo_alloggio', '')
    prezzo_min = request.GET.get('prezzo_min', '')
    prezzo_max = request.GET.get('prezzo_max', '')
    citta = request.GET.get('citta', '')
    capienza = request.GET.get('capienza', '')
    ordina = request.GET.get('ordina', '')
    
    # Costruisci la query base
    query = """
        SELECT a.id_alloggio, a.titolo, a.prezzo_notte, a.tipo_alloggio, 
               c.nome, c.nazione, c.regione, a.capienza
        FROM alloggio a
        LEFT JOIN citta c ON a.id_citta = c.id_citta
        WHERE 1=1
    """
    params = []
    
    # Aggiungi i filtri dinamicamente
    if tipo_alloggio:
        query += " AND a.tipo_alloggio = %s"
        params.append(tipo_alloggio)
    
    if prezzo_min:
        try:
            query += " AND a.prezzo_notte >= %s"
            params.append(float(prezzo_min))
        except ValueError:
            pass
    
    if prezzo_max:
        try:
            query += " AND a.prezzo_notte <= %s"
            params.append(float(prezzo_max))
        except ValueError:
            pass
    
    if citta:
        query += " AND c.nome LIKE %s"
        params.append(f"%{citta}%")
    
    if capienza:
        try:
            query += " AND a.capienza >= %s"
            params.append(int(capienza))
        except ValueError:
            pass
    
    # Applica ordinamento se richiesto (prezzo)
    if ordina == 'prezzo_asc':
        query += " ORDER BY a.prezzo_notte ASC"
    elif ordina == 'prezzo_desc':
        query += " ORDER BY a.prezzo_notte DESC"

    with connection.cursor() as cursor:
        cursor.execute(query, params)
        risultati = cursor.fetchall()
    
    alloggi = []
    
    for riga in risultati:
        alloggi.append({
            "id": riga[0],
            "titolo": riga[1],
            "prezzo_notte": riga[2],
            "tipo_alloggio": riga[3],
            "citta_nome": riga[4],
            "citta_nazione": riga[5],
            "citta_regione": riga[6],
            "capienza": riga[7],
        })
    
    # Recupera i tipi di alloggio unici per il dropdown
    with connection.cursor() as cursor:
        cursor.execute("SELECT DISTINCT tipo_alloggio FROM alloggio WHERE tipo_alloggio IS NOT NULL")
        tipi_alloggi = [row[0] for row in cursor.fetchall()]
    
    # Recupera le città uniche per il dropdown
    with connection.cursor() as cursor:
        cursor.execute("SELECT DISTINCT nome FROM citta ORDER BY nome")
        citta_list = [row[0] for row in cursor.fetchall()]
    
    context = {
        "alloggi": alloggi,
        "tipi_alloggi": tipi_alloggi,
        "citta_list": citta_list,
        "filtri_applicati": {
            "tipo_alloggio": tipo_alloggio,
            "prezzo_min": prezzo_min,
            "prezzo_max": prezzo_max,
            "citta": citta,
            "capienza": capienza,
            "ordina": ordina,
        }
    }
    
    return render(request, "lista_alloggi.html", context)


def registrazione(request):
    if request.method == 'POST':
        nome = request.POST.get('nome')
        cognome = request.POST.get('cognome')
        email = request.POST.get('email')
        password = request.POST.get('password')
        telefono = request.POST.get('telefono')

        # Sicurezza: Controlla se l'email è già usata
        if Utente.objects.filter(email=email).exists():
            messages.error(request, "Questa email è già registrata.")
            return redirect('registrazione')

        # Crea e salva l'utente criptando la password
        nuovo_utente = Utente(
            nome=nome,
            cognome=cognome,
            email=email,
            password_hash=make_password(password), # LA SICUREZZA È QUI
            telefono=telefono,
            data_registrazione=date.today()
        )
        nuovo_utente.save()
        messages.success(request, "Registrazione completata! Ora puoi accedere.")
        return redirect('login')

    return render(request, 'registrazione.html')


def login_view(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')

        try:
            utente = Utente.objects.get(email=email)
            # Sicurezza: Verifica che la password inserita corrisponda all'hash salvato
            if check_password(password, utente.password_hash):
                # Login riuscito: salviamo l'ID utente nella sessione del browser
                request.session['utente_id'] = utente.id_utente
                request.session['utente_nome'] = utente.nome
                # Flag se è host
                try:
                    from core.models import Host
                    request.session['is_host'] = Host.objects.filter(id_host_id=utente.id_utente).exists()
                except Exception:
                    request.session['is_host'] = False
                messages.success(request, f"Bentornato, {utente.nome}!")
                return redirect('home')
            else:
                messages.error(request, "Password errata.")
        except Utente.DoesNotExist:
            messages.error(request, "Nessun utente trovato con questa email.")

    return render(request, 'login.html')

def logout_view(request):
    # Svuota la sessione per disconnettere l'utente
    request.session.flush()
    messages.success(request, "Ti sei disconnesso con successo.")
    return redirect('home')

def dettaglio_alloggio(request, id_alloggio):
    alloggio = get_object_or_404(Alloggio, id_alloggio=id_alloggio)
    
    if request.method == 'POST':
        if not request.session.get('utente_id'):
            messages.error(request, "Devi essere loggato per prenotare.")
            return redirect('login')
        
        check_in_str = request.POST.get('check_in')
        check_out_str = request.POST.get('check_out')
        numero_ospiti = int(request.POST.get('numero_ospiti'))
        
        try:
            check_in = datetime.strptime(check_in_str, '%Y-%m-%d').date()
            check_out = datetime.strptime(check_out_str, '%Y-%m-%d').date()
        except ValueError:
            messages.error(request, "Date non valide.")
            return render(request, 'dettaglio_alloggio.html', {'alloggio': alloggio})
        
        if check_in >= check_out or check_in < date.today():
            messages.error(request, "Date di check-in/check-out non valide.")
            return render(request, 'dettaglio_alloggio.html', {'alloggio': alloggio})
        
        if numero_ospiti > alloggio.capienza:
            messages.error(request, "Troppi ospiti per questo alloggio.")
            return render(request, 'dettaglio_alloggio.html', {'alloggio': alloggio})
        
        # Calcola numero notti
        notti = (check_out - check_in).days
        prezzo_totale = alloggio.prezzo_notte * notti
        
        # Genera codice conferma
        codice_conferma = str(uuid.uuid4())[:8].upper()
        
        # Crea prenotazione
        try:
            PrenotazioneAlloggio.objects.create(
                data_prenotazione=date.today(),
                check_in=check_in,
                check_out=check_out,
                numero_ospiti=numero_ospiti,
                prezzo_totale=prezzo_totale,
                stato='Confermata',
                codice_conferma=codice_conferma,
                id_utente_id=request.session['utente_id'],
                id_alloggio_id=id_alloggio
            )
            
            # Passa il codice_conferma al template per mostrare il modal
            return render(request, 'dettaglio_alloggio.html', {
                'alloggio': alloggio,
                'prenotazione_confermata': True,
                'codice_conferma': codice_conferma
            })
        except DatabaseError as e:
            # Recupera recensioni per questo alloggio
            recensioni_qs = RecensioneAlloggio.objects.filter(id_prenotazione__id_alloggio=alloggio).select_related('id_prenotazione')
            recensioni = []
            for r in recensioni_qs:
                autore = None
                try:
                    ut = r.id_prenotazione.id_utente
                    autore = f"{ut.nome} {ut.cognome}"
                except Exception:
                    autore = "Ospite"
                recensioni.append({
                    'voto': r.voto,
                    'commento': r.commento,
                    'data': r.data_recensione,
                    'autore': autore,
                })
            
            error_msg = str(e)
            if "già prenotato" in error_msg or "sovrapposizione" in error_msg or "45000" in error_msg:
                errore_messaggio = "Questo alloggio è già prenotato per le date selezionate."
            else:
                errore_messaggio = f"Errore durante la prenotazione: {error_msg}"
                
            return render(request, 'dettaglio_alloggio.html', {
                'alloggio': alloggio,
                'recensioni': recensioni,
                'prenotazione_fallita': True,
                'errore_messaggio': errore_messaggio
            })
    
    # Recupera recensioni per questo alloggio
    recensioni_qs = RecensioneAlloggio.objects.filter(id_prenotazione__id_alloggio=alloggio).select_related('id_prenotazione')
    recensioni = []
    for r in recensioni_qs:
        autore = None
        try:
            ut = r.id_prenotazione.id_utente
            autore = f"{ut.nome} {ut.cognome}"
        except Exception:
            autore = "Ospite"
        recensioni.append({
            'voto': r.voto,
            'commento': r.commento,
            'data': r.data_recensione,
            'autore': autore,
        })

    return render(request, 'dettaglio_alloggio.html', {'alloggio': alloggio, 'recensioni': recensioni})

def profilo_utente(request):
    if not request.session.get('utente_id'):
        messages.error(request, "Devi essere loggato per accedere al tuo profilo.")
        return redirect('login')
    
    utente_id = request.session['utente_id']
    utente = get_object_or_404(Utente, id_utente=utente_id)
    
    # Gestione invio recensioni (da profilo)
    if request.method == 'POST' and 'recensione_alloggio' in request.POST:
        pren_id = request.POST.get('prenotazione_id')
        voto = request.POST.get('voto')
        commento = request.POST.get('commento', '').strip()
        try:
            pren = PrenotazioneAlloggio.objects.get(id_prenotazione=pren_id, id_utente_id=utente_id)
        except PrenotazioneAlloggio.DoesNotExist:
            messages.error(request, "Prenotazione non valida.")
            return redirect('profilo_utente')
        # Verifica esistenza recensione
        if RecensioneAlloggio.objects.filter(id_prenotazione=pren).exists():
            messages.error(request, "Hai già recensito questa prenotazione.")
            return redirect('profilo_utente')
        try:
            voto_int = int(voto) if voto else None
        except ValueError:
            voto_int = None
        # Controllo lato applicazione: se il check-out non è ancora passato, mostra popup e non creare
        try:
            if pren.check_out and pren.check_out > date.today():
                messages.error(request, "Puoi inserire la recensione solo dopo il check-out.", extra_tags='review_blocked')
                return redirect('profilo_utente')
        except Exception:
            pass

        RecensioneAlloggio.objects.create(
            voto=voto_int,
            commento=commento,
            data_recensione=date.today(),
            id_prenotazione=pren
        )
        messages.success(request, "Recensione inviata con successo.")
        return redirect('profilo_utente')

    if request.method == 'POST' and 'recensione_esperienza' in request.POST:
        pren_id = request.POST.get('prenotazione_id')
        voto = request.POST.get('voto')
        commento = request.POST.get('commento', '').strip()
        try:
            pren = PrenotazioneEsperienze.objects.get(id_prenotazione_esperienza=pren_id, id_utente_id=utente_id)
        except PrenotazioneEsperienze.DoesNotExist:
            messages.error(request, "Prenotazione non valida.")
            return redirect('profilo_utente')
        if RecensioneEsperienze.objects.filter(id_prenotazione_esperienza=pren).exists():
            messages.error(request, "Hai già recensito questa prenotazione.")
            return redirect('profilo_utente')
        try:
            voto_int = int(voto) if voto else None
        except ValueError:
            voto_int = None
        # Controllo lato applicazione: se la data esperienza non è ancora passata, mostra popup e non creare
        try:
            if pren.data_esperienza and pren.data_esperienza > date.today():
                messages.error(request, "Puoi inserire la recensione solo dopo aver partecipato all'esperienza.", extra_tags='review_blocked')
                return redirect('profilo_utente')
        except Exception:
            pass

        RecensioneEsperienze.objects.create(
            voto=voto_int,
            commento=commento,
            data_recensione=date.today(),
            id_prenotazione_esperienza=pren
        )
        messages.success(request, "Recensione inviata con successo.")
        return redirect('profilo_utente')

    # Gestione cambio password
    if request.method == 'POST' and 'cambio_password' in request.POST:
        password_attuale = request.POST.get('password_attuale')
        nuova_password = request.POST.get('nuova_password')
        conferma_password = request.POST.get('conferma_password')
        
        # Verifica che la password attuale sia corretta
        if not check_password(password_attuale, utente.password_hash):
            messages.error(request, "Password attuale non corretta.")
        elif len(nuova_password) < 6:
            messages.error(request, "La nuova password deve contenere almeno 6 caratteri.")
        elif nuova_password != conferma_password:
            messages.error(request, "Le password non corrispondono.")
        else:
            # Aggiorna la password
            utente.password_hash = make_password(nuova_password)
            utente.save()
            messages.success(request, "Password cambiata con successo!")
    
    # Recupera tutte le prenotazioni alloggi dell'utente
    prenotazioni_alloggi = list(PrenotazioneAlloggio.objects.filter(
        id_utente_id=utente_id
    ).select_related('id_alloggio').order_by('-data_prenotazione'))
    for p in prenotazioni_alloggi:
        p.has_review = RecensioneAlloggio.objects.filter(id_prenotazione=p).exists()
    
    # Recupera tutte le prenotazioni esperienze dell'utente
    prenotazioni_esperienze = list(PrenotazioneEsperienze.objects.filter(
        id_utente_id=utente_id
    ).select_related('id_esperienza').order_by('-data_prenotazione'))
    for p in prenotazioni_esperienze:
        p.has_review = RecensioneEsperienze.objects.filter(id_prenotazione_esperienza=p).exists()
    
    # Calcola statistiche
    totale_speso_alloggi = sum(float(p.prezzo_totale or 0) for p in prenotazioni_alloggi)
    totale_speso_esperienze = sum(float(p.prezzo_totale or 0) for p in prenotazioni_esperienze)
    totale_speso = totale_speso_alloggi + totale_speso_esperienze
    
    prenotazioni_attive = sum(1 for p in prenotazioni_alloggi if p.stato == 'Confermata') + sum(1 for p in prenotazioni_esperienze if p.stato == 'Confermata')
    
    context = {
        'utente': utente,
        'prenotazioni_alloggi': prenotazioni_alloggi,
        'prenotazioni_esperienze': prenotazioni_esperienze,
        'totale_speso': f"{totale_speso:.2f}",
        'prenotazioni_attive': prenotazioni_attive,
    }
    
    return render(request, 'profilo_utente.html', context)


def host_dashboard(request):
    # Verifica login
    if not request.session.get('utente_id'):
        messages.error(request, "Devi essere loggato per accedere alla dashboard host.")
        return redirect('login')
    utente_id = request.session['utente_id']

    # Verifica che sia host
    try:
        host = Host.objects.get(id_host_id=utente_id)
    except Exception:
        messages.error(request, "Devi essere un host per accedere a questa pagina.")
        return redirect('home')

    # Recupera alloggi gestiti
    alloggi = Alloggio.objects.filter(id_host=host)

    alloggi_data = []
    total_guadagnato = 0
    total_prenotazioni = 0
    for a in alloggi:
        pren = PrenotazioneAlloggio.objects.filter(id_alloggio_id=a.id_alloggio)
        num_pren = pren.count()
        guad = sum(float(p.prezzo_totale or 0) for p in pren)
        total_guadagnato += guad
        total_prenotazioni += num_pren
        alloggi_data.append({
            'alloggio': a,
            'numero_prenotazioni': num_pren,
            'guadagnato': f"{guad:.2f}",
        })

    # Prenotazioni recenti
    recent_pren = PrenotazioneAlloggio.objects.filter(id_alloggio_id__in=[a.id_alloggio for a in alloggi]).select_related('id_alloggio','id_utente').order_by('-data_prenotazione')[:10]

    context = {
        'host': host,
        'alloggi_data': alloggi_data,
        'total_guadagnato': f"{total_guadagnato:.2f}",
        'total_prenotazioni': total_prenotazioni,
        'recent_pren': recent_pren,
    }
    return render(request, 'host_dashboard.html', context)


def edit_alloggio(request, id_alloggio):
    if not request.session.get('utente_id'):
        messages.error(request, "Devi essere loggato per modificare l'alloggio.")
        return redirect('login')

    utente_id = request.session['utente_id']

    alloggio = get_object_or_404(Alloggio, id_alloggio=id_alloggio)
    host = get_object_or_404(Host, id_host_id=utente_id)

    if alloggio.id_host != host:
        messages.error(request, "Non hai i permessi per modificare questo alloggio.")
        return redirect('host_dashboard')

    if request.method == 'POST':
        try:
            alloggio.capienza = int(request.POST.get('capienza'))
            alloggio.numero_camere = int(request.POST.get('numero_camere'))
            alloggio.numero_letti = int(request.POST.get('numero_letti'))
            alloggio.numero_bagni = int(request.POST.get('numero_bagni'))
            alloggio.prezzo_notte = Decimal(request.POST.get('prezzo_notte'))

            alloggio.save()
            messages.success(request, "Alloggio aggiornato con successo.")
            return redirect('host_dashboard')

        except Exception as e:
            messages.error(request, f"Errore salvataggio: {e}")

    return render(request, 'edit_alloggio.html', {'alloggio': alloggio})


def lista_esperienze(request):
    # Recupera i parametri di filtro dalla request
    categoria = request.GET.get('categoria', '')
    prezzo_min = request.GET.get('prezzo_min', '')
    prezzo_max = request.GET.get('prezzo_max', '')
    luogo = request.GET.get('luogo', '')
    ordina = request.GET.get('ordina', '')
    
    # Costruisci la query base
    query = """
        SELECT e.id_esperienza, e.titolo, e.descrizione, e.prezzo, e.durata, 
               e.categoria, e.capienza_massima, e.luogo, a.nome
        FROM esperienze e
        LEFT JOIN agenzia a ON e.id_agenzia = a.id_agenzia
        WHERE 1=1
    """
    params = []
    
    # Aggiungi i filtri dinamicamente
    if categoria:
        query += " AND e.categoria = %s"
        params.append(categoria)
    
    if prezzo_min:
        try:
            query += " AND e.prezzo >= %s"
            params.append(float(prezzo_min))
        except ValueError:
            pass
    
    if prezzo_max:
        try:
            query += " AND e.prezzo <= %s"
            params.append(float(prezzo_max))
        except ValueError:
            pass
    
    if luogo:
        query += " AND e.luogo LIKE %s"
        params.append(f"%{luogo}%")
    
    # Applica ordinamento se richiesto (prezzo)
    if ordina == 'prezzo_asc':
        query += " ORDER BY e.prezzo ASC"
    elif ordina == 'prezzo_desc':
        query += " ORDER BY e.prezzo DESC"

    with connection.cursor() as cursor:
        cursor.execute(query, params)
        risultati = cursor.fetchall()
    
    esperienze = []
    
    for riga in risultati:
        esperienze.append({
            "id": riga[0],
            "titolo": riga[1],
            "descrizione": riga[2],
            "prezzo": riga[3],
            "durata": riga[4],
            "categoria": riga[5],
            "capienza_massima": riga[6],
            "luogo": riga[7],
            "agenzia_nome": riga[8],
        })
    
    # Recupera le categorie uniche per il dropdown
    with connection.cursor() as cursor:
        cursor.execute("SELECT DISTINCT categoria FROM esperienze WHERE categoria IS NOT NULL")
        categorie = [row[0] for row in cursor.fetchall()]
    
    # Recupera i luoghi unici per il dropdown
    with connection.cursor() as cursor:
        cursor.execute("SELECT DISTINCT luogo FROM esperienze WHERE luogo IS NOT NULL ORDER BY luogo")
        luoghi_list = [row[0] for row in cursor.fetchall()]
    
    context = {
        "esperienze": esperienze,
        "categorie": categorie,
        "luoghi_list": luoghi_list,
        "filtri_applicati": {
            "categoria": categoria,
            "prezzo_min": prezzo_min,
            "prezzo_max": prezzo_max,
            "luogo": luogo,
            "ordina": ordina,
        }
    }
    
    return render(request, "lista_esperienze.html", context)

def dettaglio_esperienza(request, id_esperienza):
    esperienza = get_object_or_404(Esperienze, id_esperienza=id_esperienza)
    
    if request.method == 'POST':
        if not request.session.get('utente_id'):
            messages.error(request, "Devi essere loggato per prenotare.")
            return redirect('login')
        
        data_esperienza_str = request.POST.get('data_esperienza')
        numero_partecipanti = int(request.POST.get('numero_partecipanti'))
        
        try:
            data_esperienza = datetime.strptime(data_esperienza_str, '%Y-%m-%d').date()
        except ValueError:
            messages.error(request, "Data non valida.")
            return render(request, 'dettaglio_esperienza.html', {'esperienza': esperienza})
        
        if data_esperienza < date.today():
            messages.error(request, "La data dell'esperienza non può essere nel passato.")
            return render(request, 'dettaglio_esperienza.html', {'esperienza': esperienza})
        
        if numero_partecipanti > esperienza.capienza_massima:
            messages.error(request, f"Troppi partecipanti. Capienza massima: {esperienza.capienza_massima}")
            return render(request, 'dettaglio_esperienza.html', {'esperienza': esperienza})
        
        # Calcola prezzo totale
        prezzo_totale = esperienza.prezzo * numero_partecipanti
        
        # Genera codice conferma
        codice_conferma = str(uuid.uuid4())[:8].upper()
        
        # Crea prenotazione
        try:
            PrenotazioneEsperienze.objects.create(
                data_prenotazione=date.today(),
                data_esperienza=data_esperienza,
                numero_partecipanti=numero_partecipanti,
                prezzo_totale=prezzo_totale,
                stato='Confermata',
                id_utente_id=request.session['utente_id'],
                id_esperienza_id=id_esperienza
            )
            
            # Passa il codice_conferma al template per mostrare il modal
            return render(request, 'dettaglio_esperienza.html', {
                'esperienza': esperienza,
                'prenotazione_confermata': True,
                'codice_conferma': codice_conferma
            })
        except DatabaseError as e:
            # Recupera recensioni per questa esperienza
            recensioni_qs = RecensioneEsperienze.objects.filter(id_prenotazione_esperienza__id_esperienza=esperienza).select_related('id_prenotazione_esperienza')
            recensioni = []
            for r in recensioni_qs:
                autore = None
                try:
                    ut = r.id_prenotazione_esperienza.id_utente
                    autore = f"{ut.nome} {ut.cognome}"
                except Exception:
                    autore = "Partecipante"
                recensioni.append({
                    'voto': r.voto,
                    'commento': r.commento,
                    'data': r.data_recensione,
                    'autore': autore,
                })
            
            error_msg = str(e)
            if "capienza" in error_msg or "supera" in error_msg:
                errore_messaggio = "Il numero di partecipanti supera la capienza massima prevista per questa esperienza."
            elif "passato" in error_msg:
                errore_messaggio = "La data dell'esperienza non può essere nel passato."
            else:
                errore_messaggio = f"Errore durante la prenotazione: {error_msg}"
                
            return render(request, 'dettaglio_esperienza.html', {
                'esperienza': esperienza,
                'recensioni': recensioni,
                'prenotazione_fallita': True,
                'errore_messaggio': errore_messaggio
            })
    
    # Recupera recensioni per questa esperienza
    recensioni_qs = RecensioneEsperienze.objects.filter(id_prenotazione_esperienza__id_esperienza=esperienza).select_related('id_prenotazione_esperienza')
    recensioni = []
    for r in recensioni_qs:
        autore = None
        try:
            ut = r.id_prenotazione_esperienza.id_utente
            autore = f"{ut.nome} {ut.cognome}"
        except Exception:
            autore = "Partecipante"
        recensioni.append({
            'voto': r.voto,
            'commento': r.commento,
            'data': r.data_recensione,
            'autore': autore,
        })

    return render(request, 'dettaglio_esperienza.html', {'esperienza': esperienza, 'recensioni': recensioni})