#!/bin/sh
echo "***"
echo "*** Debian VM starting. Please connect to VNC:4 or SSH port 2004"
echo "***"
(
#qemu-system-x86_64 --enable-kvm -m 4096 -smp cpus=1,cores=1 \
qemu-system-x86_64 -m 4096 -smp cpus=1,cores=1 \
	-drive format=qcow2,file=Images/debian.img \
	-cdrom Downloads/debian-11.7.0-amd64-netinst.iso -boot c \
	-device virtio-net-pci,netdev=network0 \
	-netdev user,id=network0,hostfwd=tcp::2004-:22 \
	-display vnc=:4
) & 


