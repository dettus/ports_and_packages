#!/bin/sh

echo "***"
echo "*** OpenBSD VM starting. Please connect to VNC:1 or SSH port 2001"
echo "***"
(
#qemu-system-x86_64 --enable-kvm -m 4096 -smp cpus=1,cores=1 \
qemu-system-x86_64 -m 4096 -smp cpus=1,cores=1 \
	-drive format=qcow2,file=Images/openbsd.img \
	-cdrom Downloads/install73.iso -boot c \
	-device virtio-net-pci,netdev=network0 \
	-netdev user,id=network0,hostfwd=tcp::2001-:22 \
	-display vnc=:1
) & 
