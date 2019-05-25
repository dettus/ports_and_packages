#!/bin/sh

wget -c http://www.dettus.net/dMagnetic/dMagnetic_0.13.tar.gz
tar xvfz dMagnetic_0.13.tar.gz
mv dMagnetic_0.13 dmagnetic-0.13
tar cvfz dmagnetic_0.13.orig.tar.gz dmagnetic-0.13
cd dmagnetic-0.13
dh_make
rm -rf debian
cp -r ../debian .
for I in `cat debian/patches/series`
do
	patch -p0 <debian/patches/$I
done
#debuild
#quilt (to create the makefile patch)
debian/rules clean
debian/rules build
fakeroot debian/rules binary




