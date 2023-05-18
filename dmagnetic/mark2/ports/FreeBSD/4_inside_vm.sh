#!/bin/sh

mkdir -p /usr/ports/games/dMagnetic
cd /usr/ports/games
git pull
cd dMagnetic
tar xvfz /root/PACKAGE_IN.tar.gz
git rm files/*
rm -rf files/
mkdir files/
make makesum
(
	PORTSDIR=`pwd`
	make extract
	
	cd `make -V WRKSRC`
	tar xvfz /root/PATCHES_IN.tar.gz
	
	for FILES in Makefile
	do
		diff -u $FILES.orig $FILES >$PORTSDIR/files/patch-$FILES
	done
)

#make update-patches
git add files/*

git diff main >/root/package_out.patch

make clean
make distclean
make uninstall
make install
