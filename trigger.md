# Trigger del database `HostHub`

**Totale trigger:** 14

Questo file contiene solamente il codice dei trigger implementati nel database.

## 1. `Trigger_Integrita_Dati_Agenzia`

| Campo | Valore |
|---|---|
| Tabella | `agenzia` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Controlla email, telefono e partita IVA prima dell’inserimento di una nuova agenzia. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Integrita_Dati_Agenzia` BEFORE INSERT ON `agenzia`
FOR EACH ROW
BEGIN

    IF NEW.email NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Formato email dell''agenzia non valido.';
    END IF;

    IF NEW.telefono IS NOT NULL AND NEW.telefono NOT REGEXP '^[+0-9 ]+$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il numero di telefono dell''agenzia può contenere solo numeri, spazi e +.';
    END IF;

    IF LENGTH(NEW.partita_iva) != 11 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: La Partita IVA deve contenere esattamente 11 caratteri.';
    END IF;

    IF NEW.partita_iva NOT REGEXP '^[0-9]+$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: La Partita IVA deve contenere esclusivamente numeri.';
    END IF;
END $$
DELIMITER ;
```

## 2. `Trigger_Controllo_Prezzi_Negativi_Alloggio`

| Campo | Valore |
|---|---|
| Tabella | `alloggio` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Impedisce l’inserimento di un alloggio con prezzo per notte minore o uguale a zero. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Controllo_Prezzi_Negativi_Alloggio` BEFORE INSERT ON `alloggio`
FOR EACH ROW
BEGIN
    IF NEW.prezzo_notte <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il prezzo per notte deve essere maggiore di zero.';
    END IF;
END $$
DELIMITER ;
```

## 3. `Trigger_Calcolo_Prezzo_Totale_Alloggio`

| Campo | Valore |
|---|---|
| Tabella | `prenotazione_alloggio` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Calcola automaticamente il prezzo totale della prenotazione in base al numero di notti. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Calcolo_Prezzo_Totale_Alloggio` BEFORE INSERT ON `prenotazione_alloggio`
FOR EACH ROW
BEGIN
    DECLARE prezzo_giornaliero DECIMAL(10,2);
    DECLARE giorni INT;

    SELECT prezzo_notte INTO prezzo_giornaliero
    FROM alloggio
    WHERE id_alloggio = NEW.id_alloggio;

    SET giorni = DATEDIFF(NEW.check_out, NEW.check_in);

    IF giorni > 0 THEN
        SET NEW.prezzo_totale = prezzo_giornaliero * giorni;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il check-out deve essere successivo al check-in.';
    END IF;
END $$
DELIMITER ;
```

## 4. `Trigger_Controllo_Capienza_Alloggio`

| Campo | Valore |
|---|---|
| Tabella | `prenotazione_alloggio` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Verifica che il numero di ospiti non superi la capienza massima dell’alloggio. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Controllo_Capienza_Alloggio` BEFORE INSERT ON `prenotazione_alloggio`
FOR EACH ROW
BEGIN
    DECLARE capienza_max INT;

    SELECT capienza INTO capienza_max
    FROM alloggio
    WHERE id_alloggio = NEW.id_alloggio;

    IF NEW.numero_ospiti > capienza_max THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il numero di ospiti supera la capienza massima di questo alloggio.';
    END IF;
END $$
DELIMITER ;
```

## 5. `Trigger_Controllo_Date_Sensate_Alloggio`

| Campo | Valore |
|---|---|
| Tabella | `prenotazione_alloggio` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Impedisce prenotazioni con check-in precedente alla data di prenotazione. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Controllo_Date_Sensate_Alloggio` BEFORE INSERT ON `prenotazione_alloggio`
FOR EACH ROW
BEGIN

    IF NEW.check_in < NEW.data_prenotazione THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: La data di check-in non può essere nel passato rispetto alla data di prenotazione.';
    END IF;
END $$
DELIMITER ;
```

## 6. `Trigger_Generazione_Codice_Conferma`

| Campo | Valore |
|---|---|
| Tabella | `prenotazione_alloggio` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Genera automaticamente un codice di conferma se non viene specificato. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Generazione_Codice_Conferma` BEFORE INSERT ON `prenotazione_alloggio`
FOR EACH ROW
BEGIN

    IF NEW.codice_conferma IS NULL OR NEW.codice_conferma = '' THEN

        SET NEW.codice_conferma = CONCAT('BKNG-', DATE_FORMAT(NOW(), '%Y'), '-', UPPER(SUBSTRING(MD5(RAND()), 1, 6)));
    END IF;
END $$
DELIMITER ;
```

## 7. `Trigger_Prevenzione_Sovrapposizione_Date`

| Campo | Valore |
|---|---|
| Tabella | `prenotazione_alloggio` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Impedisce prenotazioni sovrapposte per lo stesso alloggio già confermato. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Prevenzione_Sovrapposizione_Date` BEFORE INSERT ON `prenotazione_alloggio`
FOR EACH ROW
BEGIN
    DECLARE conteggio INT;

    SELECT COUNT(*) INTO conteggio
    FROM prenotazione_alloggio
    WHERE id_alloggio = NEW.id_alloggio
      AND stato = 'Confermata'
      AND (NEW.check_in < check_out AND NEW.check_out > check_in);

    IF conteggio > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: L''alloggio è già prenotato per queste date.';
    END IF;
END $$
DELIMITER ;
```

## 8. `Trigger_Calcolo_Prezzo_Totale_Esperienza`

| Campo | Valore |
|---|---|
| Tabella | `prenotazione_esperienze` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Calcola automaticamente il prezzo totale dell’esperienza in base ai partecipanti. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Calcolo_Prezzo_Totale_Esperienza` BEFORE INSERT ON `prenotazione_esperienze`
FOR EACH ROW
BEGIN
    DECLARE costo_singolo DECIMAL(10,2);

    SELECT prezzo INTO costo_singolo
    FROM esperienze
    WHERE id_esperienza = NEW.id_esperienza;

    SET NEW.prezzo_totale = costo_singolo * NEW.numero_partecipanti;
END $$
DELIMITER ;
```

## 9. `Trigger_Controllo_Capienza_Esperienza`

| Campo | Valore |
|---|---|
| Tabella | `prenotazione_esperienze` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Verifica che il numero di partecipanti non superi la capienza massima dell’esperienza. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Controllo_Capienza_Esperienza` BEFORE INSERT ON `prenotazione_esperienze`
FOR EACH ROW
BEGIN
    DECLARE capienza_max_esp INT;

    SELECT capienza_massima INTO capienza_max_esp
    FROM esperienze
    WHERE id_esperienza = NEW.id_esperienza;

    IF NEW.numero_partecipanti > capienza_max_esp THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il numero di partecipanti supera la capienza massima prevista per questa esperienza.';
    END IF;
END $$
DELIMITER ;
```

## 10. `Trigger_Controllo_Date_Sensate_Esperienza`

| Campo | Valore |
|---|---|
| Tabella | `prenotazione_esperienze` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Impedisce prenotazioni di esperienze con data precedente alla data di prenotazione. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Controllo_Date_Sensate_Esperienza` BEFORE INSERT ON `prenotazione_esperienze`
FOR EACH ROW
BEGIN

    IF NEW.data_esperienza < NEW.data_prenotazione THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: La data dell''esperienza non può essere nel passato rispetto alla data di prenotazione.';
    END IF;
END $$
DELIMITER ;
```

## 11. `Trigger_Controllo_Voto_Alloggio`

| Campo | Valore |
|---|---|
| Tabella | `recensione_alloggio` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Controlla che il voto della recensione dell’alloggio sia compreso tra 1 e 5. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Controllo_Voto_Alloggio` BEFORE INSERT ON `recensione_alloggio`
FOR EACH ROW
BEGIN

    IF NEW.voto < 1 OR NEW.voto > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il voto della recensione alloggio deve essere un numero compreso tra 1 e 5.';
    END IF;
END $$
DELIMITER ;
```

## 12. `Trigger_Recensione_Solo_Dopo_Checkout`

| Campo | Valore |
|---|---|
| Tabella | `recensione_alloggio` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Permette di recensire un alloggio solo dopo il check-out. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Recensione_Solo_Dopo_Checkout` BEFORE INSERT ON `recensione_alloggio`
FOR EACH ROW
BEGIN
    DECLARE data_fine_soggiorno DATE;

    SELECT check_out INTO data_fine_soggiorno
    FROM prenotazione_alloggio
    WHERE id_prenotazione = NEW.id_prenotazione;

    IF NEW.data_recensione <= data_fine_soggiorno THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Puoi recensire l''alloggio solo DOPO aver fatto il check-out.';
    END IF;
END $$
DELIMITER ;
```

## 13. `Trigger_Controllo_Voto_Esperienza`

| Campo | Valore |
|---|---|
| Tabella | `recensione_esperienze` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Controlla che il voto della recensione dell’esperienza sia compreso tra 1 e 5. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Controllo_Voto_Esperienza` BEFORE INSERT ON `recensione_esperienze`
FOR EACH ROW
BEGIN

    IF NEW.voto < 1 OR NEW.voto > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il voto dell''esperienza deve essere un numero compreso tra 1 e 5.';
    END IF;
END $$
DELIMITER ;
```

## 14. `Trigger_Integrita_Dati_Utente`

| Campo | Valore |
|---|---|
| Tabella | `utente` |
| Evento | `INSERT` |
| Timing | `BEFORE` |
| Funzione | Controlla email e telefono prima dell’inserimento di un nuovo utente. |

```sql
DELIMITER $$
CREATE TRIGGER `Trigger_Integrita_Dati_Utente` BEFORE INSERT ON `utente`
FOR EACH ROW
BEGIN

    IF NEW.email NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Formato email non valido. Inserisci un indirizzo corretto (es. nome@dominio.it).';
    END IF;

    IF NEW.telefono IS NOT NULL AND NEW.telefono NOT REGEXP '^[+0-9 ]+$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: Il numero di telefono può contenere solo numeri, spazi e il simbolo +.';
    END IF;
END $$
DELIMITER ;
```
