#!/bin/sh

wget -c http://www.dettus.net/dMagnetic/dMagnetic_0.13.tar.gz
bzr whoami "Thomas Dettbarn <dettus@dettus.net>"
bzr dh-make dmagnetic 0.13 dMagnetic_0.13.tar.gz
rm -rf dmagnetic/debian
cp -r debian dmagnetic
cd dmagnetic
bzr builddeb -- -us -uc
