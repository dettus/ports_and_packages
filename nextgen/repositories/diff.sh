#!/bin/sh

(
	cd OpenBSD
	cd ports/games/
	cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs diff	>../../../games_dMagnetic_openbsd_patch.txt
)

(
	cd FreeBSD
	cd dMagnetic
	svn diff >../../games_dMagnetic_freebsd_patch.txt
)

(
	cd NetBSD
	cd pkgsrc/games/
	cvs -qd anoncvs@anoncvs.NetBSD.org:/cvsroot diff >../../../games_dMagnetic_netbas_patch.txt	
)
