#!/bin/sh

export OLD_RELEASE=0.22
export NEW_RELEASE=0.23

(
	mkdir -p tmp/
	cd tmp/
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
python3 patchports.py
