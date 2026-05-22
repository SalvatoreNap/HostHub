# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Agenzia(models.Model):
    id_agenzia = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=255)
    partita_iva = models.CharField(unique=True, max_length=50)
    email = models.CharField(unique=True, max_length=255)
    telefono = models.CharField(max_length=50, blank=True, null=True)
    indirizzo_sede = models.CharField(max_length=255, blank=True, null=True)
    descrizione = models.TextField(db_column='Descrizione', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'agenzia'


class Alloggio(models.Model):
    id_alloggio = models.AutoField(primary_key=True)
    titolo = models.CharField(max_length=255)
    descrizione = models.TextField(blank=True, null=True)
    indirizzo = models.CharField(max_length=255, blank=True, null=True)
    prezzo_notte = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    capienza = models.IntegerField(blank=True, null=True)
    tipo_alloggio = models.CharField(max_length=100, blank=True, null=True)
    numero_camere = models.IntegerField(blank=True, null=True)
    numero_letti = models.IntegerField(blank=True, null=True)
    numero_bagni = models.IntegerField(blank=True, null=True)
    id_host = models.ForeignKey('Host', models.DO_NOTHING, db_column='id_host', blank=True, null=True)
    id_citta = models.ForeignKey('Citta', models.DO_NOTHING, db_column='id_citta', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'alloggio'
    
    def __str__(self):
        return f"{self.titolo} ({self.tipo_alloggio})"


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Badge(models.Model):
    id_badge = models.AutoField(primary_key=True)
    nome = models.CharField(unique=True, max_length=100)
    descrizione = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'badge'


class Citta(models.Model):
    id_citta = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=255)
    nazione = models.CharField(max_length=255)
    regione = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'citta'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Esperienze(models.Model):
    id_esperienza = models.AutoField(primary_key=True)
    titolo = models.CharField(max_length=255)
    descrizione = models.TextField(blank=True, null=True)
    prezzo = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    durata = models.CharField(max_length=50, blank=True, null=True)
    categoria = models.CharField(max_length=100, blank=True, null=True)
    capienza_massima = models.IntegerField(blank=True, null=True)
    luogo = models.CharField(max_length=255, blank=True, null=True)
    id_agenzia = models.ForeignKey(Agenzia, models.DO_NOTHING, db_column='id_agenzia', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'esperienze'


class Host(models.Model):
    id_host = models.OneToOneField('Utente', models.DO_NOTHING, db_column='id_host', primary_key=True)
    descrizione_profilo = models.TextField(blank=True, null=True)
    data_attivazione = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'host'


class Lingua(models.Model):
    id_lingua = models.AutoField(primary_key=True)
    nome = models.CharField(unique=True, max_length=100)

    class Meta:
        managed = False
        db_table = 'lingua'


class Offre(models.Model):
    pk = models.CompositePrimaryKey('id_alloggio', 'id_servizio')
    id_alloggio = models.ForeignKey(Alloggio, models.DO_NOTHING, db_column='id_alloggio')
    id_servizio = models.ForeignKey('Servizio', models.DO_NOTHING, db_column='id_servizio')

    class Meta:
        managed = False
        db_table = 'offre'


class Ottiene(models.Model):
    pk = models.CompositePrimaryKey('id_host', 'id_badge')
    id_host = models.ForeignKey(Host, models.DO_NOTHING, db_column='id_host')
    id_badge = models.ForeignKey(Badge, models.DO_NOTHING, db_column='id_badge')
    data_ottenimento = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ottiene'


class ParlaAgenzia(models.Model):
    pk = models.CompositePrimaryKey('id_agenzia', 'id_lingua')
    id_agenzia = models.ForeignKey(Agenzia, models.DO_NOTHING, db_column='id_agenzia')
    id_lingua = models.ForeignKey(Lingua, models.DO_NOTHING, db_column='id_lingua')

    class Meta:
        managed = False
        db_table = 'parla_agenzia'


class ParlaHost(models.Model):
    pk = models.CompositePrimaryKey('id_host', 'id_lingua')
    id_host = models.ForeignKey(Host, models.DO_NOTHING, db_column='id_host')
    id_lingua = models.ForeignKey(Lingua, models.DO_NOTHING, db_column='id_lingua')

    class Meta:
        managed = False
        db_table = 'parla_host'


class PrenotazioneAlloggio(models.Model):
    id_prenotazione = models.AutoField(primary_key=True)
    data_prenotazione = models.DateField(blank=True, null=True)
    check_in = models.DateField(blank=True, null=True)
    check_out = models.DateField(blank=True, null=True)
    numero_ospiti = models.IntegerField(blank=True, null=True)
    prezzo_totale = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    stato = models.CharField(max_length=50, blank=True, null=True)
    codice_conferma = models.CharField(unique=True, max_length=100, blank=True, null=True)
    id_utente = models.ForeignKey('Utente', models.DO_NOTHING, db_column='id_utente', blank=True, null=True)
    id_alloggio = models.ForeignKey(Alloggio, models.DO_NOTHING, db_column='id_alloggio', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'prenotazione_alloggio'
    
    def __str__(self):
        alloggio = self.id_alloggio.titolo if self.id_alloggio else "Sconosciuto"
        utente = f"{self.id_utente.nome} {self.id_utente.cognome}" if self.id_utente else "Sconosciuto"
        return f"Prenotazione {self.id_prenotazione}: {alloggio} - {utente}"


class PrenotazioneEsperienze(models.Model):
    id_prenotazione_esperienza = models.AutoField(primary_key=True)
    data_prenotazione = models.DateField(blank=True, null=True)
    data_esperienza = models.DateField(blank=True, null=True)
    numero_partecipanti = models.IntegerField(blank=True, null=True)
    prezzo_totale = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    stato = models.CharField(max_length=50, blank=True, null=True)
    id_utente = models.ForeignKey('Utente', models.DO_NOTHING, db_column='id_utente', blank=True, null=True)
    id_esperienza = models.ForeignKey(Esperienze, models.DO_NOTHING, db_column='id_esperienza', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'prenotazione_esperienze'
    
    def __str__(self):
        esperienza = self.id_esperienza.titolo if self.id_esperienza else "Sconosciuta"
        utente = f"{self.id_utente.nome} {self.id_utente.cognome}" if self.id_utente else "Sconosciuto"
        return f"Prenotazione {self.id_prenotazione_esperienza}: {esperienza} - {utente}"


class PuntiInteresse(models.Model):
    id_punto_interesse = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=255)
    descrizione = models.TextField(blank=True, null=True)
    categoria = models.CharField(max_length=100, blank=True, null=True)
    id_citta = models.ForeignKey(Citta, models.DO_NOTHING, db_column='id_citta', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'punti_interesse'


class RecensioneAlloggio(models.Model):
    id_recensione = models.AutoField(primary_key=True)
    voto = models.IntegerField(blank=True, null=True)
    commento = models.TextField(blank=True, null=True)
    data_recensione = models.DateField(blank=True, null=True)
    id_prenotazione = models.OneToOneField(PrenotazioneAlloggio, models.DO_NOTHING, db_column='id_prenotazione', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'recensione_alloggio'


class RecensioneEsperienze(models.Model):
    id_recensione_esperienza = models.AutoField(primary_key=True)
    voto = models.IntegerField(blank=True, null=True)
    commento = models.TextField(blank=True, null=True)
    data_recensione = models.DateField(blank=True, null=True)
    id_prenotazione_esperienza = models.OneToOneField(PrenotazioneEsperienze, models.DO_NOTHING, db_column='id_prenotazione_esperienza', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'recensione_esperienze'


class Servizio(models.Model):
    id_servizio = models.AutoField(primary_key=True)
    nome = models.CharField(unique=True, max_length=255)
    descrizione = models.TextField(blank=True, null=True)
    categoria = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'servizio'


class Utente(models.Model):
    id_utente = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=255)
    cognome = models.CharField(max_length=255)
    email = models.CharField(unique=True, max_length=255)
    password_hash = models.CharField(max_length=255)
    telefono = models.CharField(max_length=50, blank=True, null=True)
    data_registrazione = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'utente'
    
    def __str__(self):
        return f"{self.nome} {self.cognome} ({self.email})"



# --------------------------------------------------------
# VISTE (VIEW) DAL DATABASE
# --------------------------------------------------------

class VistaAlloggiConServizi(models.Model):
    id_alloggio = models.IntegerField(primary_key=True)
    titolo = models.CharField(max_length=255)
    prezzo_notte = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    tipo_alloggio = models.CharField(max_length=100, blank=True, null=True)
    id_citta = models.IntegerField(blank=True, null=True)
    servizi_offerti = models.TextField(blank=True, null=True) # Mappato da mediumtext

    class Meta:
        managed = False
        db_table = 'vista_alloggi_con_servizi'

class VistaClassificaAlloggi(models.Model):
    id_alloggio = models.IntegerField(primary_key=True)
    titolo = models.CharField(max_length=255)
    tipo_alloggio = models.CharField(max_length=100, blank=True, null=True)
    citta = models.CharField(max_length=255)
    media_voti = models.DecimalField(max_digits=12, decimal_places=1, blank=True, null=True)
    numero_recensioni = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'vista_classifica_alloggi'

class VistaClassificaEsperienze(models.Model):
    id_esperienza = models.IntegerField(primary_key=True)
    titolo = models.CharField(max_length=255)
    categoria = models.CharField(max_length=100, blank=True, null=True)
    media_voti = models.DecimalField(max_digits=12, decimal_places=1, blank=True, null=True)
    numero_recensioni = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'vista_classifica_esperienze'

class VistaDashboardGuadagniAgenzia(models.Model):
    id_agenzia = models.IntegerField(primary_key=True)
    nome_agenzia = models.CharField(max_length=255)
    numero_prenotazioni_totali = models.BigIntegerField()
    totale_guadagnato_euro = models.DecimalField(max_digits=32, decimal_places=2, blank=True, null=True)
    totale_partecipanti = models.DecimalField(max_digits=32, decimal_places=0, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vista_dashboard_guadagni_agenzia'

class VistaDashboardGuadagniHost(models.Model):
    id_host = models.IntegerField(primary_key=True)
    nome = models.CharField(max_length=255)
    cognome = models.CharField(max_length=255)
    numero_prenotazioni_totali = models.BigIntegerField()
    totale_guadagnato_euro = models.DecimalField(max_digits=32, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vista_dashboard_guadagni_host'

class VistaDettaglioPrenotazioneOspite(models.Model):
    id_prenotazione = models.IntegerField(primary_key=True)
    ospite_id = models.IntegerField(blank=True, null=True)
    nome_alloggio = models.CharField(max_length=255)
    citta_alloggio = models.CharField(max_length=255)
    check_in = models.DateField(blank=True, null=True)
    check_out = models.DateField(blank=True, null=True)
    prezzo_totale = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    stato = models.CharField(max_length=50, blank=True, null=True)
    codice_conferma = models.CharField(max_length=100, blank=True, null=True)
    nome_host = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'vista_dettaglio_prenotazione_ospite'

class VistaEsploraDintorni(models.Model):
    id_alloggio = models.IntegerField(primary_key=True)
    nome_alloggio = models.CharField(max_length=255)
    citta = models.CharField(max_length=255)
    punto_interesse = models.CharField(max_length=255)
    categoria = models.CharField(max_length=100, blank=True, null=True)
    descrizione = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vista_esplora_dintorni'

class VistaFatturazionePrenotazioni(models.Model):
    id_prenotazione = models.IntegerField(primary_key=True)
    codice_conferma = models.CharField(max_length=100, blank=True, null=True)
    data_prenotazione = models.DateField(blank=True, null=True)
    nome_ospite = models.CharField(max_length=255)
    cognome_ospite = models.CharField(max_length=255)
    alloggio_prenotato = models.CharField(max_length=255)
    nome_host_proprietario = models.CharField(max_length=255)
    cognome_host_proprietario = models.CharField(max_length=255)
    prezzo_totale = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vista_fatturazione_prenotazioni'

class VistaPrenotazioniDaRecensire(models.Model):
    id_prenotazione = models.IntegerField(primary_key=True)
    codice_conferma = models.CharField(max_length=100, blank=True, null=True)
    nome_ospite = models.CharField(max_length=255)
    email_ospite = models.CharField(max_length=255)
    nome_alloggio = models.CharField(max_length=255)
    check_out = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vista_prenotazioni_da_recensire'

class VistaProfiloAgenziaCompleto(models.Model):
    id_agenzia = models.IntegerField(primary_key=True)
    nome = models.CharField(max_length=255)
    email = models.CharField(max_length=255)
    telefono = models.CharField(max_length=50, blank=True, null=True)
    lingue_parlate = models.TextField(blank=True, null=True)
    numero_esperienze_offerte = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'vista_profilo_agenzia_completo'

class VistaProfiloHostCompleto(models.Model):
    id_utente = models.IntegerField(primary_key=True)
    nome = models.CharField(max_length=255)
    cognome = models.CharField(max_length=255)
    descrizione_profilo = models.TextField(blank=True, null=True)
    data_attivazione = models.DateField(blank=True, null=True)
    lingue_parlate = models.TextField(blank=True, null=True)
    badge_ottenuti = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'vista_profilo_host_completo'

class VistaProfiloOspiteCrm(models.Model):
    id_utente = models.IntegerField(primary_key=True)
    nome = models.CharField(max_length=255)
    cognome = models.CharField(max_length=255)
    email = models.CharField(max_length=255)
    soggiorni_effettuati = models.BigIntegerField()
    esperienze_svolte = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'vista_profilo_ospite_crm'

class VistaStatisticheServizi(models.Model):
    id_servizio = models.IntegerField(primary_key=True)
    nome_servizio = models.CharField(max_length=255)
    categoria = models.CharField(max_length=100, blank=True, null=True)
    numero_alloggi_che_lo_offrono = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'vista_statistiche_servizi'

class VistaTopDestinazioni(models.Model):
    id_citta = models.IntegerField(primary_key=True)
    citta = models.CharField(max_length=255)
    nazione = models.CharField(max_length=255)
    numero_alloggi_disponibili = models.BigIntegerField()
    numero_prenotazioni_totali = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'vista_top_destinazioni'