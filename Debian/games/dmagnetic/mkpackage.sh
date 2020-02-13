#!/bin/sh

export VERSION=22

rm -rf dMagnetic_0.${VERSION}.tar.bz2
rm -rf dmagnetic_0.${VERSION}.orig.tar.gz
rm -rf dmagnetic-0.${VERSION}



wget -c https://www.dettus.net/dMagnetic/dMagnetic_0.${VERSION}.tar.bz2
tar xvfj dMagnetic_0.${VERSION}.tar.bz2
mv dMagnetic_0.${VERSION} dmagnetic-0.${VERSION}
tar cvfz dmagnetic_0.${VERSION}.orig.tar.gz dmagnetic-0.${VERSION}
tar cvfJ dmagnetic_0.${VERSION}-1.debian.tar.xz debian

cd dmagnetic-0.${VERSION}
pwd
rm -rf debian
cp -r ../debian .
#debuild -uc -us
debuild
cd ..
debsign dmagnetic_0.${VERSION}-1_amd64.changes



