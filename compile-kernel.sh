#!/bin/bash

VERSION=$(pwd | awk '{print substr($0, match($0, "[0-9]"))}')
readonly dest_dir="/boot/gentoo"

cp -v /home/chris/Documents/custom-kernel/linux-ulm.config .config
cp /bin/busybox /usr/src/initramfs/bin
cp /sbin/cryptsetup /usr/src/initramfs/bin

make -j4
make modules_install
KERNUM=$(eselect kernel list | awk -v ver=$VERSION '$2 ~ ver {print substr($1, index($1, "[") + 1, index($1, "]") - 2)}')
eselect kernel set $KERNUM

cp -v .config /home/chris/Documents/custom-kernel/linux-ulm.config

test ! -d $dest_dir && echo "insert USB"
while test ! -d $dest_dir; do
    sleep 0.5
done

mv -v /boot/gentoo/* /boot/kernels/gentoo-old/
cp -v arch/x86/boot/bzImage /boot/gentoo/vmlinuz-$VERSION

umount /boot
