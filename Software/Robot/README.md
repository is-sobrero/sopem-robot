<h1 align="center">SoPEM Robot Firmware</h1>
<div align="center">
<img widht="720" height="720" src="images/robot_p.png">
</div>

# Tabella dei contenuti

- [Introduzione](#introduzione)
- [Descrizione del sistema](#descrizione-del-sistema)
	- [Funzionamento](#funzionamento)
	- [Descrizione dei file](#descrizione-dei-file)
- [Installazione](#installazione)
  - [Preparazione di Halocode](#preparazione-di-halocode)
  - [Configurazione ambiente di sviluppo](#configurazione-ambiente-di-sviluppo)
  - [Individuazione della porta seriale di Halocode](#individuazione-della-porta-seriale-di-halocode)
  - [Installazione firmware](#installazione-firmware)
- [Licenza](#licenza)
  - [Autori / Copyright](#autori--copyright)
  - [Licenze componenti di terze parti](#licenze-componenti-di-terze-parti)
  - [Dettagli licenza](#dettagli-licenza)

# Introduzione
Questa repo contiene il codice sorgente del robot SoPEM. 
Nonostante sia principalmente basato su Halocode, il codice essendo scritto in Micropython è facilmente portabile su altre piattaforme con minime modifiche al codice.
Lo scopo principale è di monitorare i valori di PM10 su percorsi di strada preprogrammati sull'applicazione Companion apposita.
# Descrizione del sistema
## Funzionamento
SoPEM è un robot di tipologia rover dedito alla monitorazione dei valori di particolato PM10 nell'aria. Essendo il sensore autocostruito, per ottenere valori affidabili è stato "calibrato" tramite una macchina ad intelligenza artificiale addestrata, oltre coi dati col sensore, coi dati dell'ARPA. Essendo i valori correlati da una funzione lineare, è stato scelto un algoritmo di regressione lineare per elaborare il segnale.
Una volta programmato il movimento, descritto da una stringa JSON inviata tramite MQTT al robot, esso potrà muoversi, previa autorizzazione da parte dell'operatore, eseguendo il percorso programmato. Durante il movimento il robot eseguirà una media dei valori di PM10 rilevati ad ogni movimento, che verrà restituita all'operatore alla fine dell'esecuzione della sequenza.
## Descrizione dei file
Il firmware di SoPEM è estremamente modulare, ogni file è dedito ad una specifica funzione del robot.
 - `main.py`
Questo file gestisce il comportamento generico del Robot, oltre ad essere il file automaticamente eseguito all'avvio di Halocode, esso provvede a connettere Halocode ad Internet, a configurare i motori e il protocollo MQTT per la comunicazione, gestisce il ciclo di comportamento del robot.
- `motors.py`
Questo file è il livello di astrazione tra il codice principale e l'hardware dei motori: `main.py` istanzia una classe di tipologia `motor_controller`, andando ad invocare le funzioni per il movimento degli assi dall'oggetto istanziato.
Se si dispone di un controller dei motori diverso da quello previsto nei sorgenti originali di SoPEM, è necessario modificare solamente questo file per far muovere la propria versione di SoPEM senza alcuna difficoltà particolare.
- `pm10_sense.py`
Questo file è il livello di astrazione tra il codice principale e il sensore di particolato: `main.py` istanzia una classe di tipologia `pm10_sensor`, andando ad invocare le funzioni per la lettura del valore di particolato dall'oggetto istanziato. 
Se si dispone di un sensore più avanzato rispetto a quello previsto nei sorgenti originali di SoPEM (quindi senza bisogno di regressiore lineare per l'elaborazione del valore), è necessario modificare solamente questo file per renderlo compatibile com SoPEM.
- `config.json`
Questo file contiene la configurazione del robot, dalle credenziali della rete wifi a quelle del broker MQTT, dai topic dedicati al robot agli indirizzi I2C delle periferiche. Per configurare SoPEM per le proprie esigenze, spesso è occorrente modificare solo questo file.
- `umqttsimple.py`
Questo file contiene la libreria umqtt.simple, non modificare questo file.

# Installazione
## Preparazione di Halocode
Il firmware originale di Halocode è limitato alla programmazione con Mblock, per eseguire il software di SoPEM bisogna, prima di tutto, installare il firmware adattato per l'editor Mu, seguire la guida [presente a questo link](http://docs.makeblock.com/halocode/en/tutorials/use-python-mu.html) per configurare Halocode.
Una volta installato il firmware custom, caricare un programma qualsiasi tramite l'editor Mu (Importante! altrimenti il codice main.py non verrà mai eseguito all'avvio)

## Configurazione ambiente di sviluppo
Per installare il codice su Halocode assicurarsi di avere i seguenti programmi installati:

 - Python3
 - pip
 - ampy
 - GNU Make tools
 - git

Una volta che si è sicuri di avere i seguenti programmi installati, clonare la repo con git e recarsi nella cartella coi sorgenti del SW di SoPEM
Avviare una finestra di terminale e lanciare il seguente comando:

    make check

Se un programma è mancante maketools lo segnalerà.
## Individuazione della porta seriale di Halocode
Collegare Halocode al computer.
Da qui, in base al sistema operativo host seguire le seguenti procedure:

- Windows
	- Avviare Gestione dispositivi, da qui, sotto la voce "Porte Seriali COM" individuare la porta seriale associata ad Halocode (inizia con COM)
- Linux
	- Avviare una finestra del terminale e lanciare il seguente comando:
	- `ls /dev | grep "tty."`
	- Annotarsi la porta seriale corrispondente ad Halocode (inizia con /dev/ttyUSB)
- macOS
	- Avviare una finestra del terminale e lanciare il seguente comando:
	- `ls /dev | grep "cu."`
	- Annotarsi la porta seriale corrispondente ad Halocode (inizia con /dev/cu.wchusbmodem)

## Installazione firmware
 Una volta individuata la porta seriale di Halocode, avviare l'installazione tramite il comando

    make install port="PORTA_SERIALE"

Dove PORTA_SERIALE è la stringa precedentemente individuata.
Se la procedura è andata a buon fine, è possibile scollegare e ricollegare Halocode al computer, se il terminale mostra errori a schermo, eseguire di nuovo il comando make install (non è il metodo ufficiale per caricare file su Halocode, sporadicamente ha errori di sincronizzazione con la REPL).
# Licenza
## Autori / Copyright
Copyright 2020 (c) I.S. "A. Sobrero" / SoRobot Team
## Licenze componenti di terze parti
| Strumento   | Licenza      |
|-------------|--------------|
| [Micropython](https://github.com/micropython/micropython)     | MIT License |
| [umqtt.simple](https://github.com/micropython/micropython-lib/tree/master/umqtt.simple) | MIT License  |
| [ampy](https://github.com/scientifichackers/ampy) | MIT License  |
## Dettagli licenza
Il codice sorgente è rilasciato in licenza secondo GNU General Public License v3.0, che garantisce le quattro regole fondamentali del software libero anche sui fork del firmware del robot.
Per maggiori dettagli riguardo la licenza, consultare il file [LICENSE](LICENSE).

