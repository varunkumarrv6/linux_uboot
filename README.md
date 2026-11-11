# Raspberry Pi 4: Cross-Compiled U-Boot, Headless Serial Console, Manual Linux Boot

Bring-up project on a Raspberry Pi 4 Model B: I cross-compiled upstream U-Boot, loaded it through the Pi firmware, used a 3.3 V USB-UART adapter as a headless console (no HDMI monitor), and booted Raspberry Pi OS manually from the U-Boot prompt.


## Scope (read this first)
- Built **unmodified upstream U-Boot** with the stock `rpi_4_defconfig`. No U-Boot source changes.
- Used an existing Raspberry Pi OS image (Debian 13, kernel 6.18.34+rpt-rpi-v8). I did not build a kernel or root filesystem.
- Not done: TFTP boot, custom kernel or device tree, NFS root, `boot.scr`/`uEnv.txt`, GPIO or driver work.

## Hardware
| Item | Detail |
|---|---|
| Board | Raspberry Pi 4 Model B (firmware log: board revision `d03114`) |
| Boot media | USB flash drive (SanDisk Cruzer Blade) |
| Serial adapter | FTDI-based USB-UART, 3.3 V |
| Host | Windows laptop, Tera Term, 115200 8N1, no flow control |
| Build host | Ubuntu under WSL |

Wiring (details in [docs/01-hardware-wiring.md](docs/01-hardware-wiring.md)): Pi GPIO14 (TX) to adapter RX, Pi GPIO15 (RX) to adapter TX, GND to GND.

## What I did
1. Cross-compiled U-Boot (`rpi_4_defconfig`, `aarch64-linux-gnu-gcc` 11.4.0) in WSL. See [docs/02-build-uboot.md](docs/02-build-uboot.md).
2. Copied `u-boot.bin` to the USB boot partition and set `kernel=u-boot.bin` in `config.txt` (with `enable_uart=1`, `uart_2ndstage=1`).
3. Connected the serial console and reached the `U-Boot>` prompt.
4. Manually loaded the arm64 kernel and booted Raspberry Pi OS from the U-Boot prompt. See [docs/03-boot-process.md](docs/03-boot-process.md).
5. Set up Wi-Fi with `nmcli` and enabled SSH from the serial console.

## Evidence
| File | Shows |
|---|---|
| [images/01-hardware-setup.jpg](images/01-hardware-setup.jpg) | Pi 4, FTDI adapter, 3 jumper wires, USB boot drive |
| [images/02-firmware-boot-log-tera-term.jpg](images/02-firmware-boot-log-tera-term.jpg) | Pi firmware boot log over serial (Tera Term) |
| [images/04-uboot-to-linux-login-REDACTED.jpg](images/04-uboot-to-linux-login-REDACTED.jpg) | U-Boot `fatload` + `booti`, then Linux login (network details blacked out) |
| [images/03-ssh-service-logs.png](images/03-ssh-service-logs.png) | `sshd` listening on port 22 after restart |

## Problems found and how they were handled
See [docs/04-troubleshooting-log.md](docs/04-troubleshooting-log.md). Highlights: swapped TX/RX gave a blank terminal; a typo in `config.txt`; missing `gnutls` header at build time; `nmcli` Wi-Fi error fixed by deleting the saved connection; U-Boot MMC and Ethernet timeouts (not fixed).

## Known limitations
- `bootcmd=bootflow scan` fails; booting works only through the manual commands.
- U-Boot Ethernet PHY negotiation times out, and no cable was available, so TFTP was never tried.
- The `linux,cma` 512 MiB warning appears during boot; the system still boots.
- The build script in `scripts/` is **untested** as written (see its header).

## Lessons learned
- UART TX/RX must cross over; a blank terminal is usually wiring.
- The Pi firmware (`start4.elf`) runs before U-Boot and loads it through the `kernel=` setting in `config.txt`.
- Serial console output depends on matching `console=` arguments in the boot arguments.

