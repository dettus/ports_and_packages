#!/bin/sh

cd /usr/pkgsrc/games/dMagnetic
git pull
tar xvfz /root/PACKAGE_IN.tar.gz
git rm patches/*
make makesum
#(
#  cd /usr/ports/pobj/d11amp-0.61/d11amp_0.61/
#  sh /root/package_patch.sh
#)

#make update-patches
#git add patches/*

git diff --staged >/root/package_out.patch


