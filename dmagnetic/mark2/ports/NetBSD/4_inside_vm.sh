#!/bin/sh

cd /usr/pkgsrc/games/dMagnetic
git pull
tar xvfz /root/PACKAGE_IN.tar.gz
git rm -f patches/*
rm -rf patches/
unset PKG_PATH
make makesum
(
	make extract
	cd work/dMagnetic_0.37
	tar xvfz /root/PATCHES_IN.tar.gz
)
mkpatches
rm patches/*.orig
make makepatchsum
git add patches/*

git diff HEAD >/root/package_out.patch

make deinstall
make clean
make distclean
make install


