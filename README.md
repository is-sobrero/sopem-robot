<h1 align="center">SoPEM Robot</h1>
<div align="center">
      <a href="https://www.youtube.com/watch?v=lT5buDZkqcU&t">
     <img 
      src="https://img.youtube.com/vi/lT5buDZkqcU/0.jpg" 
      alt="Copertina video" 
      style="width:100%;">
      </a><br>
      <i>Clicca la copertina per guardare il video di presentazione</i><br><br><br>
      <img widht="205" height="60" src="https://i0.wp.com/www.olimpiadirobotica.it/wp-content/uploads/2019/01/cropped-Tavola-disegno-1-copia-3_png.png?w=413&ssl=1">
</div>

# Tabella dei contenuti
- [Introduzione](#introduzione)
- [Filosofia Open Source in ogni aspetto](#filosofia-open-source-in-ogni-aspetto)
- [Singoli componenti](#singoli-componenti)
- [Licenza](#licenza)
  - [Autori / Copyright](#autori--copyright)
  - [Dettagli licenza](#dettagli-licenza)

# Introduzione
SoPEM è un robot di tipologia rover studiato appositamente per le finali delle Olimpiadi di Robotica 2020 (anche se in lockdown).
Sfruttando materiali di riciclo, sono stati costruiti 3 robot, dall'aspetto diverso ma tutti e tre volti allo stesso scopo: monitorare i valori di PM10 delle città in modo autonomo con un sensore autocostruito con materiali di riciclo (Un LED infrarosso ricavato da un telecomando e un fotodiodo da un vecchio decoder).

In complemento al robot, è stata sviluppata una applicazione che permette di impostare il percorso da far eseguire al robot e per ottenere i valori di PM10 in tempo reale. 
L'applicazione, sviluppata tramite il framework Flutter 

# Filosofia Open Source in ogni aspetto
Il robot, oltre ad essere completamente Open Source, è anche sviluppato con strumenti Open Source: da Micropython a Flutter, da KiCad ad Arduino, tutti questi strumenti sono completamente Open e supportati dalla community FOSS e OSHW.

# Singoli componenti
- [Motor Controller](https://github.com/is-sobrero/sopem-robot/tree/master/Software/Motor%20Controller)
- [Sensore PM10](https://github.com/is-sobrero/sopem-robot/tree/master/Hardware/dust_sensor)
- [SoPEM Companion](https://github.com/is-sobrero/sopem-robot/tree/master/Software/sopem_companion)
- [SoPEM Fitter](https://github.com/is-sobrero/sopem-robot/tree/master/Machine%20Learning)

# Licenza
## Autori / Copyright
Copyright 2020 (c) I.S. "A. Sobrero" / SoRobot Team
## Dettagli licenza
Il codice sorgente è rilasciato in licenza secondo GNU General Public License v3.0, che garantisce le quattro regole fondamentali del software libero anche sui fork del firmware del robot.
Le schematiche dell'Hardware sono rilasciate in licenza secondo CERN Open Hardware Licence v1.2, che definisce le condizioni entro cui le schematiche possono essere usate, modificate e distribuite.
Per maggiori dettagli riguardo la licenza, consultare il file [LICENSE](https://github.com/is-sobrero/sopem-robot/blob/master/LICENSE) generale per la repo oppure i file LICENSE per le singole componenti.
