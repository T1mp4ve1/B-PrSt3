USE master;

CREATE DATABASE PrSt_3;

--inizio creazione tabelle
CREATE TABLE ANAGRAFICA (
idAnagrafica INT IDENTITY NOT NULL PRIMARY KEY,
Cognome NVARCHAR(30) NOT NULL,
Nome NVARCHAR(30) NOT NULL,
Indirizzo NVARCHAR(100) NULL,
Citta NVARCHAR(100) NULL,
CAP CHAR(5) NULL,
CF CHAR(16) NULL
)

CREATE TABLE TIPO_VIOLAZIONE (
idViolazione INT IDENTITY NOT NULL PRIMARY KEY,
Descrizione NVARCHAR(200) NOT NULL
)

CREATE TABLE AGENTE (
idAgente INT IDENTITY NOT NULL PRIMARY KEY,
Cognome NVARCHAR(30) NOT NULL,
Nome NVARCHAR(30) NOT NULL
)

CREATE TABLE VERBALE (
idVerbale INT IDENTITY NOT NULL PRIMARY KEY,
Data_Violazione DATETIME NOT NULL,
Indirizzo_Violazione NVARCHAR(100) NOT NULL,
idAgente INT NOT NULL,
Data_Trascrizione DATETIME NOT NULL,
Importo DECIMAL(8,2) NOT NULL,
Decurtamento_Punti INT NOT NULL
)

ALTER TABLE VERBALE ADD idAnagrafica INT NOT NULL;
ALTER TABLE VERBALE ADD idViolazione INT NOT NULL;
--fine creazione tabelle

--inizio collegamenti
ALTER TABLE VERBALE ADD CONSTRAINT FK_VERBALE_ANAGRAFICA FOREIGN KEY (idAnagrafica) REFERENCES ANAGRAFICA(idAnagrafica);
ALTER TABLE VERBALE ADD CONSTRAINT FK_VERBALE_TIPO_VIOLAZIONE FOREIGN KEY (idViolazione) REFERENCES TIPO_VIOLAZIONE(idViolazione);
ALTER TABLE VERBALE ADD CONSTRAINT FK_VERBALE_AGENTE FOREIGN KEY (idAgente) REFERENCES AGENTE(idAgente);
--fine collegamenti

--inizio inserimento dati
INSERT INTO AGENTE (Cognome, Nome) VALUES
('Rossi', 'Luca'),
('Bianchi', 'Martina'),
('Verdi', 'Andrea'),
('Neri', 'Simone'),
('Ferrari', 'Elena');
SELECT * FROM AGENTE; --5

INSERT INTO ANAGRAFICA (Cognome, Nome, Indirizzo, Citta, CAP, CF) VALUES
('Rossi', 'Marco', 'Via Roma 12', 'Milano', '20100', 'RSSMRC80A01F205X'),
('Bianchi', 'Laura', 'Corso Torino 45', 'Torino', '10100', 'BNCLRA85B41L219X'),
('Verdi', 'Alessandro', 'Via Napoli 7', 'Roma', '00100', 'VRDALS90C15H501X'),
('Neri', 'Francesca', 'Via Firenze 33', 'Firenze', '50100', 'NRIFNC92D23D612X'),
('Ferrari', 'Giovanni', 'Piazza Venezia 10', 'Roma', '00100', 'FRRGVN88E11H501X'),
('Esposito', 'Sara', 'Via Toledo 56', 'Napoli', '80100', 'SPTSRA91H63F839X'),
('Galli', 'Lorenzo', 'Via Garibaldi 8', 'Genova', '16100', 'GLLLRN87M15D969X'),
('Romano', 'Chiara', 'Via dei Mille 21', 'Bari', '70100', 'RMNCHR89L55A662X'),
('Conti', 'Paolo', 'Via Veneto 18', 'Roma', '00100', 'CNTPLL93M16H501X'),
('De Luca', 'Elisa', 'Corso Umberto 5', 'Napoli', '80100', 'DLCELS90D45F839X');
SELECT * FROM ANAGRAFICA; --10

INSERT INTO TIPO_VIOLAZIONE (Descrizione) VALUES
('Eccesso di velocità'),
('Sosta vietata'),
('Passaggio con semaforo rosso'),
('Guida senza cintura di sicurezza'),
('Utilizzo del cellulare alla guida'),
('Mancata precedenza'),
('Circolazione in area pedonale non autorizzata'),
('Mancata revisione del veicolo'),
('Guida sotto effetto di alcol'),
('Coglione');
SELECT * FROM TIPO_VIOLAZIONE; --10

INSERT INTO VERBALE (idAnagrafica, idViolazione, idAgente, Data_Violazione, Indirizzo_Violazione, Data_Trascrizione, Importo, Decurtamento_Punti) VALUES
(7, 8, 3, '2025-11-01 09:30:00', 'Via Roma 12, Milano', '2025-11-02 10:00:00', 545.76, 6),
(5, 1, 2, '2025-11-03 14:20:00', 'Corso Torino 45, Torino', '2025-11-04 11:15:00', 37.23, 3),
(10, 10, 4, '2025-11-05 17:45:00', 'Via Napoli 7, Roma', '2025-11-06 09:30:00', 154.22, 2),
(4, 8, 1, '2025-11-07 12:00:00', 'Via Firenze 33, Firenze', '2025-11-08 13:00:00', 1203.33, 2),
(5, 1, 2, '2025-11-09 08:15:00', 'Piazza Venezia 10, Roma', '2025-11-09 15:30:00', 77.54, 5),
(3, 9, 5, '2025-11-10 10:50:00', 'Via Toledo 56, Napoli', '2025-11-11 09:00:00', 94.30, 1),
(6, 6, 4, '2025-11-12 16:20:00', 'Via Garibaldi 8, Genova', '2025-11-12 11:45:00', 110.32, 5),
(3, 3, 4, '2025-11-02 14:10:00', 'Via dei Mille 21, Bari', '2025-11-05 10:20:00', 130.33, 4),
(9, 8, 5, '2025-11-03 18:30:00', 'Via Veneto 18, Roma', '2025-11-11 09:50:00', 250.77, 10),
(4, 3, 3, '2025-11-11 09:05:00', 'Corso Umberto 5, Napoli', '2025-11-09 08:40:00', 180.88, 3);
SELECT * FROM VERBALE;
SELECT
V.Data_Violazione,
V.Indirizzo_Violazione,
V.idAgente,
V.Data_Trascrizione,
V.Importo,
V.Decurtamento_Punti,
V.idAnagrafica,
A.Cognome + ' ' + A.Nome AS Colpevole,
V.idViolazione,
TV.Descrizione AS Violazione FROM VERBALE V
JOIN ANAGRAFICA A ON V.idAnagrafica = A.idAnagrafica
JOIN TIPO_VIOLAZIONE TV ON V.idViolazione = TV.idViolazione;
--fine inserimento

