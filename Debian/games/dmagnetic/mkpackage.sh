#!/bin/sh

rm -rf dMagnetic_0.20.tar.bz2
rm -rf dmagnetic_0.20.orig.tar.gz
rm -rf dmagnetic-0.20



wget -c https://www.dettus.net/dMagnetic/dMagnetic_0.20.tar.bz2
tar xvfj dMagnetic_0.20.tar.bz2
mv dMagnetic_0.20 dmagnetic-0.20
tar cvfz dmagnetic_0.20.orig.tar.gz dmagnetic-0.20
tar cvfJ dmagnetic_0.20-1.debian.tar.xz debian

cd dmagnetic-0.20
pwd
rm -rf debian
cp -r ../debian .
#debuild -uc -us
debuild
cd ..
debsign dmagnetic_0.20-1_amd64.changes



