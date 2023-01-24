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

make update-patches
git add patches/*

git diff --staged >/root/package_out.patch


