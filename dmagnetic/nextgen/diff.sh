#!/bin/sh

export VERSIONNUM=`cat versionnumber.txt`
echo $VERSIONNUM
(
	cp output/OpenBSD/* repositories/OpenBSD/ports/games/dmagnetic/
	cp output/OpenBSD/pkg/* repositories/OpenBSD/ports/games/dmagnetic/pkg

	cd repositories
	cd OpenBSD
	cd ports/games/
	git diff >../../../games_dMagnetic_openbsd_patch_to_$VERSIONNUM.txt
)

(
	cp output/FreeBSD/* repositories/FreeBSD/freebsd-ports/games/dMagnetic/
	cd repositories
	cd FreeBSD
	cd freebsd-ports/games
	cd dMagnetic
	git diff >../../../../games_dMagnetic_freebsd_patch_to_$VERSIONNUM.txt
)

(
	cp output/NetBSD/* repositories/NetBSD/pkgsrc/games/dMagnetic/
	cd repositories
	cd NetBSD
	cd pkgsrc/games/
	cvs -qd anoncvs@anoncvs.NetBSD.org:/cvsroot diff >../../../games_dMagnetic_netbsd_patch_to_$VERSIONNUM.txt	
)

ls -l repositories/*patch*.txt


echo "send the OpenBSD patch to ports@openbsd.org, sthen@openbsd.org"
echo "send the FreeBSD patch to https://bugs.freebsd.org/submit/ (Remember the +)"
echo "send the NetBSD patch to https://www.netbsd.org/cgi-bin/sendpr.cgi?gndb=netbsd and a short message to wiz@netbsd.org"



