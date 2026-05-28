# Guida all'Installazione e Configurazione di `HostHub`

**Tecnologie Principali:** Django 6.0.5, MySQL su WSL, Python 3

Questo file contiene le istruzioni dettagliate, passo dopo passo, per avviare il progetto **HostHub** sulla propria macchina. La guida assume che l'ambiente di sviluppo utilizzi **Windows** per l'esecuzione del server Django e **WSL (Windows Subsystem for Linux)** per ospitare il database MySQL.

---

## 1. Configurazione del Database MySQL su WSL

Per permettere a Django (in esecuzione su Windows) di connettersi al database MySQL (in esecuzione all'interno del sottosistema Linux WSL), è necessario configurare MySQL in modo che accetti connessioni esterne ed importare la struttura dei dati.

### Tabella dei Parametri di Connessione

| Parametro | Valore | Descrizione |
|---|---|---|
| **DBMS** | MySQL | Il sistema di gestione database utilizzato dal progetto |
| **Nome Database** | `HostHub` | Nome del database da creare |
| **Utente DB** | `django_user` | Nome utente con privilegi completi |
| **Password** | `hosthub_db_pass` | Password associata all'utente `django_user` |
| **Porta** | `3306` | Porta standard di ascolto MySQL |

---

### Passo 1.1: Configurare MySQL per accettare connessioni da Windows
1. Aprire il terminale di **WSL** (es. Ubuntu).
2. Modificare il file di configurazione di MySQL per consentire l'ascolto su tutti gli indirizzi IP:
   ```bash
   sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
   ```
3. Individuare la riga `bind-address` e modificarla impostandola su `0.0.0.0`:
   ```ini
   bind-address = 0.0.0.0
   ```
4. Salvare il file (`Ctrl + O`, poi `Invio`) e uscire (`Ctrl + X`).
5. Riavviare il servizio MySQL:
   ```bash
   sudo service mysql restart
   ```

---

### Passo 1.2: Creare il Database e l'Utente dedicato
1. Accedere alla console di MySQL come root su WSL:
   ```bash
   sudo mysql -u root -p
   ```
2. Creare il database `HostHub`:
   ```sql
   CREATE DATABASE HostHub;
   ```
3. Creare l'utente dedicato abilitando l'accesso da qualsiasi host (`%`):
   ```sql
   CREATE USER 'django_user'@'%' IDENTIFIED BY 'hosthub_db_pass';
   ```
4. Assegnare tutti i privilegi del database all'utente appena creato:
   ```sql
   GRANT ALL PRIVILEGES ON HostHub.* TO 'django_user'@'%';
   FLUSH PRIVILEGES;
   ```
5. Uscire da MySQL:
   ```sql
   EXIT;
   ```

---

### Passo 1.3: Importare il Dump del Database
Per popolare il database con la struttura delle tabelle, i dati iniziali, i trigger e le viste, importare il file `dump.sql` fornito nel progetto.

1. Posizionarsi nella directory del progetto all'interno di WSL (oppure copiare il file `dump.sql` nella cartella home di WSL).
2. Eseguire il comando di importazione:
   ```bash
   mysql -u django_user -p HostHub < dump.sql
   ```
3. Inserire la password `hosthub_db_pass` quando richiesto.

---

## 2. Allineamento dell'IP di WSL in Django

Poiché WSL assegna dinamicamente un indirizzo IP alla macchina virtuale ad ogni riavvio di Windows, è necessario verificare che Django punti all'IP corretto.

1. Sul terminale di **WSL**, eseguire il seguente comando per ottenere l'indirizzo IP attuale:
   ```bash
   hostname -I
   ```
   *(Esempio di output: `172.20.196.81`)*

2. Aprire il file di configurazione di Django [settings.py](file:///c:/Users/sosna/Pictures/universita/Base%20di%20Dati/Progetto%20HostHub/Sito%20HostHub/sito_hosthub/settings.py) su Windows.
3. Individuare il dizionario `DATABASES` e aggiornare il campo `HOST` inserendo l'IP appena ottenuto:
   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.mysql',
           'NAME': 'HostHub',
           'USER': 'django_user',
           'PASSWORD': 'hosthub_db_pass',
           'HOST': '172.20.196.81',  # <-- Sostituire con l'IP di WSL
           'PORT': '3306',
       }
   }
   ```

---

## 3. Configurazione dell'Ambiente Virtuale Python (su Windows)

Eseguire questi comandi da un terminale Windows (PowerShell o Prompt dei Comandi) all'interno della cartella principale del progetto:

### Passo 3.1: Attivare l'ambiente virtuale esistente
Se la cartella `.venv` è già presente, attivarla:
* **Su PowerShell**:
  ```powershell
  .venv\Scripts\Activate.ps1
  ```
* **Su Prompt dei Comandi**:
  ```cmd
  .venv\Scripts\activate.bat
  ```

*(Se l'ambiente virtuale non esiste, crearlo prima con `python -m venv .venv`)*

### Passo 3.2: Installare le dipendenze
Installare tutti i pacchetti Python richiesti indicati nel file `requirements.txt`:
```bash
pip install -r requirements.txt
```

---

## 4. Esecuzione dell'Applicazione Web

Una volta completata la configurazione del database e delle dipendenze, avviare il server Django locale:

### Passo 4.1: Avviare il Server Django
Eseguire il comando di avvio del server di sviluppo:
```bash
python manage.py runserver
```

### Passo 4.2: Accedere all'Applicazione
Aprire il proprio browser preferito e digitare il seguente indirizzo:
```text
http://127.0.0.1:8000/
```

Il portale **HostHub** è ora pronto ed operativo.
