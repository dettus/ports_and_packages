#!/bin/sh

rm -rf dMagnetic_0.16
rm -rf dmagnetic-0.16
rm -rf build
rm -rf dMagnetic-0.16.tar.gz
rm -rf *.deb


wget -c http://www.dettus.net/dMagnetic/dMagnetic_0.16.tar.gz

tar xvfz dMagnetic_0.16.tar.gz
#mv dMagnetic_0.16 dmagnetic_0.16
mv dMagnetic_0.16 build
mkdir dmagnetic-0.16
(
	cd build
	export PREFIX=../dmagnetic-0.16/usr/
	make install
)

mkdir dmagnetic-0.16/DEBIAN
(
echo "Package: dmagnetic"
echo "Version: 0.16"
echo "Section: custom"
echo "Priority: optional"
echo "Architecture: all"
echo "Essential: no"
echo -n "Installed-Size: "
du -scb dmagnetic-0.16/usr | tail -n 1 | awk -F" " '{ print $1; }' -
echo "Maintainer: Thomas Dettbarn <dettus@dettus.net>"
echo "Description: A Magnetic Scrolls Interpreter"
echo " dMagnetic- A Magnetic Scrolls Interpreter allows you to play"
echo " classic text adventures such as 'The Pawn', 'The Guild of"
echo " Thieves', 'Jinxter', 'Myth', 'Fish!', 'Corruption' and "
echo " 'Wonderland' on modern Computers. The beautiful graphics are"
echo " being rendered in glorious ANSI art."
) > dmagnetic-0.16/DEBIAN/control

dpkg-deb --build dmagnetic-0.16
mv dmagnetic-0.16.deb dmagnetic-0.16_`uname -i`.deb

