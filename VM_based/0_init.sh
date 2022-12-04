#!/bin/sh

mkdir -p Downloads Keys Images

echo "***"
echo "*** Downloading installation iso images"
echo "***"
(
 cd Downloads
 wget -c "https://ftp.fau.de/pub/OpenBSD/7.2/amd64/install72.iso"
 wget -c "https://download.freebsd.org/ftp/releases/ISO-IMAGES/13.1/FreeBSD-13.1-RELEASE-amd64-dvd1.iso"
 wget -c "https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.3/images/NetBSD-9.3-amd64.iso"
 wget -c "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.5.0-amd64-netinst.iso"
 )

echo "***"
echo "*** Creating the ssh key"
echo "***"
mkdir Keys
ssh-keygen -N "" -f Keys/ssh-keyfile -b 2048 -t ed25519

echo "***"
echo "*** Creating Images"
echo "***"
qemu-img create -f qcow2 Images/openbsd.img 32G
qemu-img create -f qcow2 Images/freebsd.img 32G
qemu-img create -f qcow2 Images/netbsd.img 32G
qemu-img create -f qcow2 Images/debian.img 32G


echo "***"
echo "*** Ready to install"
echo "***"

