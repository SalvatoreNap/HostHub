from django.test import TestCase, Client
from django.urls import reverse
from unittest.mock import patch, MagicMock
from django.db import DatabaseError
from core.models import Alloggio, Esperienze

class BookingErrorPopupTestCase(TestCase):
    def setUp(self):
        self.client = Client()

    @patch('core.views.get_object_or_404')
    @patch('core.views.RecensioneAlloggio.objects.filter')
    @patch('core.views.PrenotazioneAlloggio.objects.create')
    def test_booking_database_error_triggers_popup(self, mock_create, mock_recensioni_filter, mock_get_object):
        # 1. Mock get_object_or_404 to return a mock Alloggio instance
        mock_alloggio = MagicMock(spec=Alloggio)
        mock_alloggio.id_alloggio = 1
        mock_alloggio.titolo = "Alloggio di Test"
        mock_alloggio.capienza = 4
        mock_alloggio.prezzo_notte = 50.0
        mock_get_object.return_value = mock_alloggio
        
        # 2. Mock RecensioneAlloggio.objects.filter to return empty list
        mock_recensioni_filter.return_value.select_related.return_value = []
        
        # 3. Setup mock create to raise DatabaseError (which MySQL trigger would raise)
        mock_create.side_effect = DatabaseError("Errore: L'alloggio è già prenotato per queste date.")
        
        # Setup session to log in
        session = self.client.session
        session['utente_id'] = 999
        session['utente_nome'] = "Test User"
        session.save()
        
        url = reverse('dettaglio_alloggio', args=[1])
        
        # Send post request to book
        response = self.client.post(url, {
            'check_in': '2026-07-01',
            'check_out': '2026-07-05',
            'numero_ospiti': 2
        })
        
        # Assert that request completed successfully without showing 500 error page
        self.assertEqual(response.status_code, 200)
        
        # Verify context contains error flags
        self.assertTrue(response.context['prenotazione_fallita'])
        self.assertEqual(response.context['errore_messaggio'], "Questo alloggio è già prenotato per le date selezionate.")
        
        # Verify that warning modal is rendered in the HTML content
        self.assertContains(response, 'id="errorModal"')
        self.assertContains(response, 'Questo alloggio è già prenotato per le date selezionate.')

class ExperienceBookingErrorPopupTestCase(TestCase):
    def setUp(self):
        self.client = Client()

    @patch('core.views.get_object_or_404')
    @patch('core.views.RecensioneEsperienze.objects.filter')
    @patch('core.views.PrenotazioneEsperienze.objects.create')
    def test_experience_booking_database_error_triggers_popup(self, mock_create, mock_recensioni_filter, mock_get_object):
        # 1. Mock get_object_or_404 to return a mock Esperienze instance
        mock_esperienza = MagicMock(spec=Esperienze)
        mock_esperienza.id_esperienza = 1
        mock_esperienza.titolo = "Esperienza di Test"
        mock_esperienza.capienza_massima = 10
        mock_esperienza.prezzo = 25.0
        mock_get_object.return_value = mock_esperienza
        
        # 2. Mock RecensioneEsperienze.objects.filter to return empty list
        mock_recensioni_filter.return_value.select_related.return_value = []
        
        # 3. Setup mock create to raise DatabaseError (which MySQL trigger would raise)
        mock_create.side_effect = DatabaseError("Errore: Il numero di partecipanti supera la capienza massima prevista per questa esperienza.")
        
        # Setup session to log in
        session = self.client.session
        session['utente_id'] = 999
        session['utente_nome'] = "Test User"
        session.save()
        
        url = reverse('dettaglio_esperienza', args=[1])
        
        # Send post request to book
        response = self.client.post(url, {
            'data_esperienza': '2026-07-01',
            'numero_partecipanti': 5
        })
        
        # Assert that request completed successfully without showing 500 error page
        self.assertEqual(response.status_code, 200)
        
        # Verify context contains error flags
        self.assertTrue(response.context['prenotazione_fallita'])
        self.assertEqual(response.context['errore_messaggio'], "Il numero di partecipanti supera la capienza massima prevista per questa esperienza.")
        
        # Verify that warning modal is rendered in the HTML content
        self.assertContains(response, 'id="errorModal"')
        self.assertContains(response, 'Il numero di partecipanti supera la capienza massima prevista per questa esperienza.')
