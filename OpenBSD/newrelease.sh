#!/bin/sh

wget http://www.dettus.net/dMagnetic/dMagnetic_0.17.tar.gz
ls -l dMagnetic_0.17.tar.gz
sha256sum dMagnetic_0.17.tar.gz



cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports
cp ports/games/dmagnetic/Makefile Makefile.orig
cp ports/games/dmagnetic/distinfo distinfo.orig
cp games/dmagnetic/Makefile Makefile
cp games/dmagnetic/distinfo distinfo

diff -u Makefile.orig Makefile >dmagnetic_016_to_017.patch
diff -u distinfo.orig distinfo >>dmagnetic_016_to_017.patch

