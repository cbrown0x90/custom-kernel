#!/bin/bash

VERSION=$(pwd | awk '{print substr($0, match($0, "[0-9]"))}')
readonly dest_dir="/boot/gentoo"

cp -v /home/chris/Documents/custom-kernel/linux-ulm.config .config

cp /bin/busybox /usr/src/initramfs/bin
cp /sbin/cryptsetup /usr/src/initramfs/bin
cp -L /usr/lib64/libcryptsetup.so.12 /usr/src/initramfs/usr/lib64/libcryptsetup.so.12
cp -L /usr/lib64/libpopt.so.0 /usr/src/initramfs/usr/lib64/libpopt.so.0
cp -L /lib64/libuuid.so.1 /usr/src/initramfs/usr/lib64/libuuid.so.1
cp -L /lib64/libc.so.6 /usr/src/initramfs/usr/lib64/libc.so.6
cp -L /lib64/libdevmapper.so.1.02 /usr/src/initramfs/usr/lib64/libdevmapper.so.1.02
cp -L /usr/lib64/libcrypto.so.1.0.0 /usr/src/initramfs/usr/lib64/libcrypto.so.1.0.0
cp -L /usr/lib64/libargon2.so.1 /usr/src/initramfs/usr/lib64/libargon2.so.1
cp -L /usr/lib64/libjson-c.so.4 /usr/src/initramfs/usr/lib64/libjson-c.so.4
cp -L /lib64/ld-linux-x86-64.so.2 /usr/src/initramfs/usr/lib64/ld-linux-x86-64.so.2
cp -L /lib64/librt.so.1 /usr/src/initramfs/usr/lib64/librt.so.1
cp -L /lib64/libpthread.so.0 /usr/src/initramfs/usr/lib64/libpthread.so.0
cp -L /lib64/libm.so.6 /usr/src/initramfs/usr/lib64/libm.so.6
cp -L /lib64/libdl.so.2 /usr/src/initramfs/usr/lib64/libdl.so.2
cp -L /lib64/libz.so.1 /usr/src/initramfs/usr/lib64/libz.so.1

make -j8
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
