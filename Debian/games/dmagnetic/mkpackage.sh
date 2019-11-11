#!/bin/sh

rm -rf dMagnetic_0.18.tar.gz
rm -rf dmagnetic_0.18.orig.tar.gz
rm -rf dmagnetic-0.18



wget -c https://www.dettus.net/dMagnetic/dMagnetic_0.18.tar.gz
tar xvfz dMagnetic_0.18.tar.gz
mv dMagnetic_0.18 dmagnetic-0.18
tar cvfz dmagnetic_0.18.orig.tar.gz dmagnetic-0.18
tar cvfJ dmagnetic_0.18-1.debian.tar.xz debian

###(
###echo -n "Format: " ; cat debian/source/format
###echo "Source: dmagnetic"
###echo "Binary: dmagnetic"
###echo "Architecture: any"
###echo "Version: 0.18-1"
###grep "^Maintainer" debian/control
###echo "Uploaders: Thomas Dettbarn <dettus@dettus.net>"
###grep "^Homepage" debian/control
###grep "^Standards-Version" debian/control
###grep "^Build-Depends" debian/control
###echo "Package-List:"
###echo " dmagnetic deb games optional arch=any"
###echo "Checksums-Sha1:"
###for I in dmagnetic_0.18.orig.tar.gz dmagnetic_0.18-1.debian.tar.xz
###do
###	echo -n " "`sha1sum $I | awk -F" " '{ print $1; }' -`" "
###	echo `wc -c $I`
###done
###
###echo "Checksums-Sha256:"
###for I in dmagnetic_0.17.orig.tar.gz dmagnetic_0.17-1.debian.tar.xz
###do
###	echo -n " "`sha256sum $I | awk -F" " '{ print $1; }' -`" "
###	echo `wc -c $I`
###done
###
###echo "Files:"
###for I in dmagnetic_0.18.orig.tar.gz dmagnetic_0.18-1.debian.tar.xz
###do
###	echo -n " "`md5sum $I | awk -F" " '{ print $1; }' -`" "
###	echo `wc -c $I`
###done
###) >/tmp/dmagnetic_0.18-1.dsc
###
cd dmagnetic-0.18
pwd
rm -rf debian
cp -r ../debian .
#debuild -uc -us
debuild
cd ..
debsign dmagnetic_0.18-1_amd64.changes
#dh_make

#for I in `cat debian/patches/series`
#do
#	cat debian/patches/$I | patch
#done
#debuild
#quilt (to create the makefile patch)
#debian/rules clean
#debian/rules build
#fakeroot debian/rules binary




