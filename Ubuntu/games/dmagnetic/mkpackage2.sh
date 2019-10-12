#!/bin/sh

# Following http://packaging.ubuntu.com/html/packaging-new-software.html

rm -rf dMagnetic_0.17
rm -rf dmagnetic-0.17
rm -rf build
rm -rf dMagnetic_0.17.tar.gz
rm -rf *.deb


wget -c http://www.dettus.net/dMagnetic/dMagnetic_0.17.tar.gz


bzr dh-make dmagnetic 0.17 dMagnetic_0.17.tar.gz
cd dmagnetic

echo "--------------------------------"
rm -rf debian 
cp -vr ../debian_ubuntu debian
echo "--------------------------------"
bzr add debian/source/format
bzr commit -m "Initial commit of Ubuntu packaging."
bzr builddeb -- -us -uc

