# Boot process

## Path 1: firmware loads U-Boot
With `kernel=u-boot.bin` in `config.txt`, the Pi firmware loads U-Boot instead of the Linux kernel. Firmware log line: `Loaded 'u-boot.bin' to 0x200000`.

`config/config.txt` contains the full file. The key lines:

```
[all]
enable_uart=1
uart_2ndstage=1
kernel=u-boot.bin
```

## Path 2: manual Linux boot from the U-Boot prompt
Commands visible in `images/04-uboot-to-linux-login-REDACTED.jpg`:

```
U-Boot> usb start
U-Boot> fatload usb 0:1 0x08000000 kernel8.img
10168774 bytes read
U-Boot> booti 0x08000000 - ${fdt_addr}
```

U-Boot printed `Starting kernel ...`, Linux booted, and the serial console showed a Debian GNU/Linux 13 login. Kernel: `6.18.34+rpt-rpi-v8` (aarch64).

Why these steps: `usb start` initialises USB storage, `fatload` copies the kernel from the FAT partition into RAM, and `booti` starts an arm64 kernel image, using the device tree that the firmware passed to U-Boot (`${fdt_addr}`).

## Path 3: firmware boots Linux directly
`images/02-firmware-boot-log-tera-term.jpg` shows the Pi firmware (without U-Boot) reading `config.txt`, `kernel8.img`, `initramfs8`, `bcm2711-rpi-4-b.dtb` and `cmdline.txt`, then starting Linux. The `cmdline.txt` at that time is in `config/cmdline.txt`.

## Warnings seen during a successful boot
- U-Boot: `ERROR: reserving fdt memory region failed`
- Kernel: `OF: reserved mem: failed to allocate memory for node 'linux,cma': size 512 MiB`
