#!/bin/bash

VERSION=$(pwd | awk '{print substr($0, match($0, "[0-9]"))}')

cp /home/chris/Documents/custom-kernel/linux-ulm.config .config
make -j4
make modules_install
KERNUM=$(eselect kernel list | awk '/\[[0-9]\]/{print substr($1, index($1, "[") + 1, index($1, "]") - 2)}' | sort -r | head -1)
eselect kernel set $KERNUM

cp .config /home/chris/Documents/custom-kernel/linux-ulm.config

test ! -d /boot/gentoo && echo -n "Insert USB" && read

mv /boot/gentoo/* /boot/kernels/gentoo-old/
cp arch/x86/boot/bzImage /boot/gentoo/vmlinuz-$VERSION
/home/chris/Documents/custom-kernel/initramfs-script $VERSION

umount /boot
