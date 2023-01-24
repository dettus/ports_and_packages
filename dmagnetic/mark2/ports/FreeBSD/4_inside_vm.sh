#!/bin/sh

mkdir -p /usr/ports/games/dMagnetic
cd /usr/ports/games
git pull
cd dMagnetic
tar xvfz /root/PACKAGE_IN.tar.gz
git rm patches/*
make makesum
git add *

git diff --staged >/root/package_out.patch


