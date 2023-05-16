#!/bin/sh

echo "***"
echo "*** FreeBSD VM starting. Please connect to VNC:2 or SSH port 2002"
echo "***"
(
#qemu-system-x86_64 --enable-kvm -m 4096 -smp cpus=1,cores=1 \
qemu-system-x86_64 -m 4096 -smp cpus=1,cores=1 \
	-drive format=qcow2,file=Images/freebsd.img \
	-cdrom Downloads/FreeBSD-13.2-RELEASE-amd64-dvd1.iso -boot c \
	-device virtio-net-pci,netdev=network0 \
	-netdev user,id=network0,hostfwd=tcp::2002-:22 \
	-display vnc=:2
) &
