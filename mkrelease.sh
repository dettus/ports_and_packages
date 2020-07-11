#!/bin/sh

export ANCIENT_RELEASE=0.22
export OLD_RELEASE=0.23
export NEW_RELEASE=0.24

(
	mkdir -p tmp/dettus.net/
	cd tmp/dettus.net/
	wget -c http://www.dettus.net/dMagnetic/dMagnetic_$NEW_RELEASE.tar.bz2
	
	for I in $OLD_RELEASE $NEW_RELEASE
	do
		wget -c http://www.dettus.net/dMagnetic/dMagnetic_$I.tar.bz2

		tar xvfj dMagnetic_$I.tar.bz2
		(
			cd dMagnetic_$I
			make || gmake
			(
				cd testcode		
				for MODE in none monochrome monochrome_inv low_ansi low_ansi2 high_ansi high_ansi2 sixel	
				do
					echo Hello | ../dMagnetic -ini ../dMagnetic.ini -mag minitest.mag -gfx minitest.gfx -vmode $MODE -vecho -vcols 300 -vrows 300  >../../"minitest_"$I"_"$MODE".log"
				done
			)
		)
	done
)
(
	mkdir -p tmp/FreeBSD/ports/games/
	cd tmp/FreeBSD/ports/games/
	svn co svn://svn.FreeBSD.org/ports/head/games/dMagnetic
)
(
	mkdir -p tmp/OpenBSD
	cd tmp/OpenBSD/
	echo "yes" | cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports/games/dmagnetic
)
(
	mkdir -p tmp/NetBSD
	cd tmp/NetBSD
	echo "yes" | cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -P pkgsrc/games/dMagnetic
)
pwd

python3 patchports.py

cp -r new/OpenBSD/ports/* OpenBSD/
cp -r new/FreeBSD/ports/* FreeBSD/
cp -r new/NetBSD/pkgsrc/* NetBSD/

cp -r new/Debian/* Debian/games/dmagnetic/

