#!/biu/sh

(
	mkdir OpenBSD
	cd OpenBSD
	mkdir -p ports/games/
	cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports/games/dmagnetic
)
(
	mkdir -p FreeBSD
	cd FreeBSD
	svn checkout svn://svn.FreeBSD.org/ports/head/games/dMagnetic
)
(
	mkdir NetBSD
	cd NetBSD
	cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -P pkgsrc/games/dMagnetic 	
)
(
	mkdir Debian
	cd Debian
	dget http://deb.debian.org/debian/pool/main/d/dmagnetic/dmagnetic_0.27-1.dsc
)
