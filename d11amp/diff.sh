#!/bin/sh

export VERSIONNUM=`cat versionnumber.txt`
echo $VERSIONNUM
(
	mkdir -p repositories/OpenBSD/ports/audio/d11amp/
	mkdir -p repositories/OpenBSD/ports/audio/d11amp/pkg

	cp output/OpenBSD/* repositories/OpenBSD/ports/audio/d11amp/
	cp output/OpenBSD/pkg/* repositories/OpenBSD/ports/audio/d11amp/pkg/

	cd repositories
	cd OpenBSD
	cd audio/d11amp
	git add d11amp/*
	git add d11amp/pkg/*
	git diff >../../../audio_d11amp_openbsd_patch_to_$VERSIONNUM.txt
)

(
	mkdir -p repositories/FreeBSD/freebsd-ports/audio/d11amp/

	cp output/FreeBSD/* repositories/FreeBSD/freebsd-ports/audio/d11amp/
	cd repositories
	cd FreeBSD
	cd freebsd-ports/audio
	cd d11amp
	git add d11amp/*
	git diff >../../../../audio_d11amp_freebsd_patch_to_$VERSIONNUM.txt
)

(
	mkdir -p repositories/NetBSD/pkgsrc/audio/d11amp/
	cp output/NetBSD/* repositories/NetBSD/pkgsrc/audio/d11amp/
	cd repositories
	cd NetBSD
	cd audio/d11amp/
	cvs -qd anoncvs@anoncvs.NetBSD.org:/cvsroot diff >../../../audio_d11amp_netbsd_patch_to_$VERSIONNUM.txt	
)

ls -l repositories/*patch*.txt


echo "send the OpenBSD patch to ports@openbsd.org, sthen@openbsd.org"
echo "send the FreeBSD patch to https://bugs.freebsd.org/submit/ (Remember the +)"
echo "send the NetBSD patch to https://www.netbsd.org/cgi-bin/sendpr.cgi?gndb=netbsd and a short message to wiz@netbsd.org"



