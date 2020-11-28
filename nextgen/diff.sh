#!/bin/sh

export VERSIONNUM=`cat versionnumber.txt`
echo $VERSIONNUM
(
	cp output/OpenBSD/* repositories/OpenBSD/ports/games/dmagnetic/
	cp output/OpenBSD/pkg/* repositories/OpenBSD/ports/games/dmagnetic/pkg

	cd repositories
	cd OpenBSD
	cd ports/games/
	cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs diff	>../../../games_dMagnetic_openbsd_patch_to_$VERSIONNUM.txt
)

(
	cp output/FreeBSD/* repositories/FreeBSD/dMagnetic/
	cd repositories
	cd FreeBSD
	cd dMagnetic
	svn diff >../../games_dMagnetic_freebsd_patch_to_$VERSIONNUM.txt
)

(
	cp output/NetBSD/* repositories/NetBSD/pkgsrc/games/dMagnetic/
	cd repositories
	cd NetBSD
	cd pkgsrc/games/
	cvs -qd anoncvs@anoncvs.NetBSD.org:/cvsroot diff >../../../games_dMagnetic_netbsd_patch_to_$VERSIONNUM.txt	
)

ls -l repositories/*patch*.txt

