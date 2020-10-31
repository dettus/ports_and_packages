#!/bin/sh
(
mkdir tmp
cd tmp
cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -P pkgsrc/games/dMagnetic
)
mkdir a
mkdir b
cp -r tmp/pkgsrc/games a
cp -r games b

diff -u a/games/dMagnetic b/games/dMagnetic >pkgsrc_games_dMagnetic_0.25_to_0.26.patch

ls -l *.patch

echo "now go to https://www.netbsd.org/cgi-bin/sendpr.cgi?gndb=netbsd" 
echo "and send a short message to wiz@netbsd.org"

