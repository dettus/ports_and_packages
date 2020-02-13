#!/bin/sh

wget http://www.dettus.net/dMagnetic/dMagnetic_0.22.tar.bz2
ls -l dMagnetic_0.22.tar.bz2
sha256sum dMagnetic_0.22.tar.bz2



cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports
cp ports/games/dmagnetic/Makefile Makefile.orig
cp ports/games/dmagnetic/distinfo distinfo.orig
cp games/dmagnetic/Makefile Makefile
cp games/dmagnetic/distinfo distinfo

diff -u Makefile.orig Makefile >dmagnetic_020_to_022.patch
diff -u distinfo.orig distinfo >>dmagnetic_020_to_022.patch

rm Makefile distinfo


echo please mail this patch to OpenBSD: Mail to ports@openbsd.org
ls -l *.patch

