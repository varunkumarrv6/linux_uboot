
set -euo pipefail

sudo apt update
sudo apt install -y git make gcc bison flex bc libssl-dev libgnutls28-dev \
    device-tree-compiler swig python3-dev python3-setuptools \
    gcc-aarch64-linux-gnu

git clone https://source.denx.de/u-boot/u-boot.git
cd u-boot
git checkout 527115ef6783   # commit shown in the U-Boot version string

make rpi_4_defconfig
make CROSS_COMPILE=aarch64-linux-gnu- -j"$(nproc)"

ls -l u-boot.bin
echo "Copy u-boot.bin to the boot partition of the USB drive and set kernel=u-boot.bin in config.txt"
