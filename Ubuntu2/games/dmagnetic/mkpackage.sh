#!/bin/sh

# following http://packaging.ubuntu.com/ubuntu-packaging-guide.pdf

rm -rf dmagnetic* dMagnetic*

wget -c https://www.dettus.net/dMagnetic/dMagnetic_0.17.tar.gz

export DEBFULLNAME="Thomas Dettbarn"
export DEBEMAIL="dettus@dettus.net"


