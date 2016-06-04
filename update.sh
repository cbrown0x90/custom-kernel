#!/bin/bash
VERSION=4.6.1

cp linux-$VERSION/arch/x86/boot/bzImage /boot/$VERSION-ULM
mount /dev/mapper/ssd /mnt/ssd

mount --bind /lib/modules/ /mnt/ssd/arch/lib/modules/
mount --rbind /dev /mnt/ssd/arch/dev
mount -t proc /proc /mnt/ssd/arch/proc
mount --rbind /sys /mnt/ssd/arch/sys
mount /dev/sda1 /mnt/ssd/arch/boot

sed "s/REPLACE/$VERSION/" linux-ulm.preset > /mnt/ssd/arch/etc/mkinitcpio.d/linux-ulm.preset
chroot /mnt/ssd/arch root/kernel-update
