#!/bin/sh

wget http://www.dettus.net/dMagnetic/dMagnetic_0.23.tar.bz2
ls -l dMagnetic_0.23.tar.bz2
sha256sum dMagnetic_0.23.tar.bz2


(
	mkdir -p ports/games/
	cd ports/games/
	cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports/games/dmagnetic
)
cp ports/games/dmagnetic/Makefile Makefile.orig
cp ports/games/dmagnetic/distinfo distinfo.orig
cp games/dmagnetic/Makefile Makefile
cp games/dmagnetic/distinfo distinfo

diff -u Makefile.orig Makefile >dmagnetic_022_to_023.patch
diff -u distinfo.orig distinfo >>dmagnetic_022_to_023.patch

rm Makefile distinfo


echo please mail this patch to OpenBSD: Mail to ports@openbsd.org
ls -l *.patch

