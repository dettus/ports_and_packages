#!/bin/sh
#-rw-r--r-- 1 det det     197120 Nov 28 12:47 debian11_5.img
#-rw-r--r-- 1 det det     197120 Nov 28 12:47 freebsd13_1.img
#-rw-r--r-- 1 det det     197120 Nov 28 12:47 netbsd10.img
#-rw-r--r-- 1 det det 2513371136 Nov 28 13:06 openbsd7_2.img

#-rw-rw-r-- 1 det det  400556032 Sep 10 14:40 debian-11.5.0-amd64-netinst.iso
#-rw-rw-r-- 1 det det 4621281280 Mai 12  2022 FreeBSD-13.1-RELEASE-amd64-dvd1.iso
#-rw-rw-r-- 1 det det  583352320 Sep 27 20:20 install72.iso
#-rw-rw-r-- 1 det det  490084352 Aug  4 20:30 NetBSD-9.3-amd64.iso

echo "***"
echo "*** NetBSD VM starting. Please connect to VNC:3 or SSH port 2003"
echo "***"
(
qemu-system-x86_64 --enable-kvm -m 4096 -smp cpus=1,cores=1 \
	-drive format=qcow2,file=Images/netbsd.img \
	-cdrom Downloads/NetBSD-9.3-amd64.iso -boot c \
	-device virtio-net-pci,netdev=network0 \
	-netdev user,id=network0,hostfwd=tcp::2003-:22 \
	-display vnc=:3
)


