# Basket Coach — versione cloud per staff

Questa cartella contiene una prima versione web condivisa di Basket Coach.

## Funzioni incluse
- Accesso email/password per allenatori invitati.
- Archivio condiviso nel cloud.
- Schede con data, squadra, durata, obiettivo e più esercizi.
- Editor grafico: attacco, difesa, pallone, cono, passaggio, movimento, palleggio, testo e gomma.
- Layout disegno/descrizione affiancato o verticale.
- Stampa tramite funzione Stampa del browser (scegliere “Salva come PDF”).

## Attivazione del cloud (serve un progetto Supabase)
1. Crea un progetto su https://supabase.com/.
2. Apri il progetto e vai in **SQL Editor**.
3. Incolla ed esegui il contenuto di `schema.sql`.
4. I dati API pubblici del progetto sono già inseriti in `config.js`.
5. Il file `config.js` incluso in questo pacchetto è già configurato con il Project URL e la publishable key forniti. Non sostituirli, a meno che tu non cambi progetto.
6. In Supabase → Authentication, disattiva la registrazione pubblica.
7. In Authentication → Users, invita gli allenatori e assegna loro una password secondo il flusso Supabase.
8. Pubblica `index.html` e `config.js` su un hosting statico HTTPS, ad esempio GitHub Pages, Netlify o Cloudflare Pages. Carica anche eventuali altri file della cartella (in questa versione bastano i due file più lo schema SQL, che serve solo per configurare il database).

## Sicurezza e condivisione
- Il sito usa soltanto la chiave anon/publishable, mai la `service_role`.
- Le policy RLS dello schema consentono l'accesso alle schede solo agli utenti autenticati.
- Tutti gli utenti invitati allo stesso progetto condividono lo stesso archivio.
- Chiunque sia autorizzato può leggere, modificare e cancellare le schede: è una modalità “staff condiviso”. Prima dell'uso reale, se vuoi distinguere allenatori, responsabili e amministratori, occorre aggiungere ruoli e permessi specifici.
- Non pubblicare il sito con registrazione libera se vuoi mantenere l'accesso riservato.

## Nota sul salvataggio
Le modifiche diventano condivise quando si preme **Salva nel cloud**. La versione iniziale non effettua ancora sincronizzazione collaborativa in tempo reale mentre due persone modificano contemporaneamente la stessa scheda: per evitare sovrascritture, concordate chi modifica una scheda alla volta. Questa funzione può essere aggiunta in una fase successiva.
