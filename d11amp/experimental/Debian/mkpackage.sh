#!/bin/bash

export VERSION=0.59

rm -rf d11amp_${VERSION}.tar.bz2
rm -rf d11amp_${VERSION}.orig.tar.gz
rm -rf d11amp-${VERSION}

wget -c https://www.dettus.net/d11amp/d11amp_${VERSION}.tar.bz2
tar xvfj d11amp_${VERSION}.tar.bz2
mv d11amp_${VERSION} d11amp-${VERSION}
tar cvfz d11amp_${VERSION}.orig.tar.gz d11amp-${VERSION}
tar cvfJ d11amp_${VERSION}-1.debian.tar.xz debian




cd d11amp-${VERSION}
cp -r ../debian .
pwd
debuild
cd ..
debsign d11amp_${VERSION}-1_amd64.changes


