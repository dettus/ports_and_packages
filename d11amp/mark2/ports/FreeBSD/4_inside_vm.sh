#!/bin/sh

mkdir -p /usr/ports/audio/d11amp/
cd /usr/ports/audio/
git pull
cd d11amp
tar xvfz /root/PACKAGE_IN.tar.gz
git rm patches/*
make makesum
git add *

git diff --staged >/root/package_out.patch


