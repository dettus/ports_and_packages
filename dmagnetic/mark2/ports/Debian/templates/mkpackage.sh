#!/bin/bash

export VERSION=%%VERSIONNUMBERHERE%%

rm -rf dmagnetic_${VERSION}.tar.bz2
rm -rf dmagnetic_${VERSION}.orig.tar.gz
rm -rf dmagnetic-${VERSION}

wget -c https://www.dettus.net/dMagnetic/dMagnetic_${VERSION}.tar.bz2
tar xvfj dMagnetic_${VERSION}.tar.bz2
mv dMagnetic_${VERSION} dmagnetic-${VERSION}
tar cvfz dmagnetic_${VERSION}.orig.tar.gz dmagnetic-${VERSION}
tar cvfJ dmagnetic_${VERSION}-1.debian.tar.xz debian




cd dmagnetic-${VERSION}
cp -r ../debian .
pwd
debuild
cd ..
debsign dmagnetic_${VERSION}-1_amd64.changes

