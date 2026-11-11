# Building U-Boot

Environment: Ubuntu under WSL on Windows. Source in `~/u-boot`.

Toolchain: `aarch64-linux-gnu-gcc` 11.4.0

```sh
make rpi_4_defconfig
make CROSS_COMPILE=aarch64-linux-gnu-
```

Output: `u-boot.bin` (about 713 KB), copied to the USB boot partition.

Version printed on the serial console after boot:

```
U-Boot 2026.10-rc2-00045-g527115ef6783
DRAM:  7.9 GiB
RPI 4 Model B (0xd03114)
```

`527115ef6783` is the git commit the build came from (`git checkout 527115ef6783` reproduces the source tree).

Build timestamp: Aug 15 2026 02:05:44 +0530.

## Build problem
Compilation first failed on a missing `gnutls/gnutls.h`. Installing the GnuTLS development package (`libgnutls28-dev` on Ubuntu) fixed it.

