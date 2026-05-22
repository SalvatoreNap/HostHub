from django.contrib import admin
from .models import (
    Alloggio, Utente, Esperienze, PrenotazioneAlloggio, PrenotazioneEsperienze,
    Citta, Host, Agenzia, Badge, Servizio, Lingua
)

# Configurazione Alloggio
@admin.register(Alloggio)
class AlloggioAdmin(admin.ModelAdmin):
    list_display = ('titolo', 'tipo_alloggio', 'prezzo_notte', 'capienza', 'id_citta')
    list_filter = ('tipo_alloggio', 'id_citta')
    search_fields = ('titolo', 'descrizione')

# Configurazione Utente
@admin.register(Utente)
class UtenteAdmin(admin.ModelAdmin):
    list_display = ('nome', 'cognome', 'email', 'telefono', 'data_registrazione')
    list_filter = ('data_registrazione',)
    search_fields = ('nome', 'cognome', 'email')
    readonly_fields = ('data_registrazione',)

# Configurazione Esperienze
@admin.register(Esperienze)
class EsperienzeAdmin(admin.ModelAdmin):
    list_display = ('titolo', 'categoria', 'prezzo', 'luogo', 'capienza_massima')
    list_filter = ('categoria', 'luogo')
    search_fields = ('titolo', 'descrizione')

# Configurazione PrenotazioneAlloggio
@admin.register(PrenotazioneAlloggio)
class PrenotazioneAlloggioAdmin(admin.ModelAdmin):
    list_display = ('id_alloggio', 'id_utente', 'check_in', 'check_out', 'prezzo_totale', 'stato')
    list_filter = ('stato', 'data_prenotazione', 'check_in')
    search_fields = ('id_utente__email', 'id_alloggio__titolo', 'codice_conferma')
    readonly_fields = ('data_prenotazione', 'codice_conferma')

# Configurazione PrenotazioneEsperienze
@admin.register(PrenotazioneEsperienze)
class PrenotazioneEsperienzeAdmin(admin.ModelAdmin):
    list_display = ('id_esperienza', 'id_utente', 'data_esperienza', 'numero_partecipanti', 'prezzo_totale', 'stato')
    list_filter = ('stato', 'data_prenotazione', 'data_esperienza')
    search_fields = ('id_utente__email', 'id_esperienza__titolo')
    readonly_fields = ('data_prenotazione',)

# Configurazione Citta
@admin.register(Citta)
class CittaAdmin(admin.ModelAdmin):
    list_display = ('nome', 'nazione', 'regione')
    list_filter = ('nazione',)
    search_fields = ('nome',)

# Configurazione Host
@admin.register(Host)
class HostAdmin(admin.ModelAdmin):
    list_display = ('id_host', 'data_attivazione')
    list_filter = ('data_attivazione',)

# Configurazione Agenzia
@admin.register(Agenzia)
class AgenziaAdmin(admin.ModelAdmin):
    list_display = ('nome', 'email', 'telefono', 'partita_iva')
    search_fields = ('nome', 'email', 'partita_iva')

# Configurazione Badge
@admin.register(Badge)
class BadgeAdmin(admin.ModelAdmin):
    list_display = ('nome',)
    search_fields = ('nome',)

# Configurazione Servizio
@admin.register(Servizio)
class ServizioAdmin(admin.ModelAdmin):
    list_display = ('nome', 'categoria')
    list_filter = ('categoria',)
    search_fields = ('nome',)

# Configurazione Lingua
@admin.register(Lingua)
class LinguaAdmin(admin.ModelAdmin):
    list_display = ('nome',)
    search_fields = ('nome',)
