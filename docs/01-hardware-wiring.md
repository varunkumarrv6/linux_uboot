# Hardware and wiring

| Raspberry Pi 4 header | Function | Adapter pin |
|---|---|---|
| Pin 8 (GPIO14) | UART TX | RX |
| Pin 10 (GPIO15) | UART RX | TX |
| Pin 6 | GND | GND |

- The adapter must be set to **3.3 V**. Pi GPIO pins are not 5 V tolerant.
- Do not connect the adapter's power pin to the Pi; the Pi is powered through USB-C via C type charging cable.
- Terminal settings: 115200 baud, 8 data bits, no parity, 1 stop bit, no flow control.
- The photo in `images/01-hardware-setup.jpg` shows three jumper wires; the pin mapping above is from my own wiring notes.

First attempt: TX and RX were connected straight through (following a reversed pinout diagram) and Tera Term stayed blank. Crossing them fixed it.
