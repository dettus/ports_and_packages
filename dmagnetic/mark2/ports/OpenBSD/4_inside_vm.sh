#!/bin/sh

cd /usr/ports/games/dmagnetic
git pull
tar xvfz /root/PACKAGE_IN.tar.gz
git rm patches/*
make makesum
#(
#  cd /usr/ports/pobj/dmagnetic-0.35/d11amp_0.35/
#  sh /root/package_patch.sh
#)
(
	cd `make show=WRKSRC`
	tar xvfz /root/patches_in.tar.gz
)
make update-patches
git add patches/*

git diff >/root/package_out.patch


