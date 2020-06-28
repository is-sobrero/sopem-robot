<h1 align="center">SoPEM Motor Controller</h1>
<div align="center">
<img widht="512" height="512" src="board.png">
</div>

- [Introduzione](#introduzione)
- [Esecuzione](#esecuzione)
  - [Prerequisiti](#prerequisiti)
  - [Flash del firmware](#flash-del-firmware)
- [Licenza](#licenza)
  - [Autori / Copyright](#autori--copyright)
  - [Licenze componenti di terze parti](#licenze-componenti-di-terze-parti)
  - [Dettagli licenza](#dettagli-licenza)
  
# Introduzione
Questa repo contiene il codice sorgente del Motor Controller - L'adattatore I2C per il controllo dei motori.
Il microprocessore utilizzato è un Atmel ATTiny85 cloccato a 16 MHz (pll interno).
# Installazione
## Prerequisiti
Assicurarsi che le definizioni per ATTinyCore siano installate, inoltre impostare l'IDE di Arduino per l'upload su ATTiny85, Clock: Internal 16 MHz.
## Flash del firmware
Caricare il firmware tramite l'IDE di Arduino o tramite un comando avrdude
Una volta assicurati che il firmware sia in esecuzione, impostare i fuses del chip secondo quanto descritto:

     -U lfuse:w:0xf1:m -U hfuse:w:0x57:m -U efuse:w:0xff:m
ATTENZIONE! : Impostando i seguenti fuses, il piedino di reset non funzionerà più come tale ma verrà incluso nei registri IO come PB5, per poter programmare di nuovo il chip non si potrà più usare ISP ma si dovrà usare un programmatore ad alto voltaggio.
# Licenza
## Autori / Copyright
Copyright 2020 (c) I.S. "A. Sobrero" / SoRobot Team
## Licenze componenti di terze parti
| Strumento   | Licenza      |
|-------------|--------------|
| [Arduino](https://github.com/arduino/Arduino)     | GNU General Public License v2.0 |
| [avrdude](http://savannah.nongnu.org/projects/avrdude) |GNU General Public License v2.0  |
| [ATTinyCore](https://github.com/SpenceKonde/ATTinyCore) |Non specificata  |
## Dettagli licenza
Il codice sorgente è rilasciato in licenza secondo GNU General Public License v3.0, che garantisce le quattro regole fondamentali del software libero anche sui fork del firmware.
Per maggiori dettagli riguardo la licenza, consultare il file [LICENSE](LICENSE).
