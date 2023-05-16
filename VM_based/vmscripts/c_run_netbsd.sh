#!/bin/sh

echo "***"
echo "*** NetBSD VM starting. Please connect to VNC:3 or SSH port 2003"
echo "***"
(
#qemu-system-x86_64 --enable-kvm -m 4096 -smp cpus=1,cores=1 \
qemu-system-x86_64 -m 4096 -smp cpus=1,cores=1 \
	-drive format=qcow2,file=Images/netbsd.img \
	-cdrom Downloads/NetBSD-9.3-amd64.iso -boot c \
	-device virtio-net-pci,netdev=network0 \
	-netdev user,id=network0,hostfwd=tcp::2003-:22 \
	-display vnc=:3
) &


