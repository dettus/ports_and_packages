#!/bin/sh

cd /usr/ports/games/dmagnetic
git pull
tar xvfz /root/PACKAGE_IN.tar.gz
git rm patches/*
rm -rf patches
make makesum
(
	make extract
	cd `make show=WRKSRC`
	tar xvfz /root/PATCHES_IN.tar.gz
)

make update-patches
git add patches/*

git diff >/root/package_out.patch
git diff --staged >>/root/package_out.patch

make clean
make distclean
make uninstall
make install

