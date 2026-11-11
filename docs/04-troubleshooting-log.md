# Troubleshooting log

| Problem | Cause | Outcome |
|---|---|---|
| Blank Tera Term screen | TX/RX not crossed | Fixed by crossing TX to RX and RX to TX |
| Firmware could not find U-Boot | `config.txt` had `kerenel=u-boot.bin` (typo); at one point the firmware reported `kernel file u-boot does not exist` | Fixed with `kernel=u-boot.bin`; log then showed `Loaded 'u-boot.bin'` |
| `gnutls/gnutls.h` missing during build | GnuTLS development package not installed | Fixed by installing `libgnutls28-dev` |
| `nmcli` Wi-Fi error: `802-11-wireless-security.key-mgmt: property is missing` | Broken saved connection profile | Fixed by deleting the saved connection and reconnecting |
| `Card did not respond to voltage select` (MMC) | Not investigated | Not fixed; USB storage works independently |
| Ethernet `PHY auto negotiation ... TIMEOUT` | No Ethernet cable connected | Not fixed; TFTP not tried |
| EFI bootflow `Cannot load any image` | Default `bootcmd=bootflow scan` | Not fixed; manual `fatload`/`booti` works |
| Linux stopped at `Starting kernel ...` in earlier attempts | Console arguments, not fully diagnosed | Later boots succeeded; root cause not recorded |
| SSH login failures from the laptop | Account lockout, SSH settings and client config issues | Resolved after resetting the lockout and SSH settings; later `sshd` shown listening on port 22 |
