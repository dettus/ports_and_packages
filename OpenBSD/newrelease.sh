#!/bin/sh
export OLD_RELEASE=0.25
export NEW_RELEASE=0.26

(
	mkdir -p ports/games/
	cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports/games/dmagnetic
)
cp ports/games/dmagnetic/Makefile Makefile.orig
cp ports/games/dmagnetic/distinfo distinfo.orig
cp games/dmagnetic/Makefile Makefile
cp games/dmagnetic/distinfo distinfo

diff -u Makefile.orig Makefile >"dmagnetic_"$OLD_RELEASE"_to_"$NEW_RELEASE".patch"
diff -u distinfo.orig distinfo >>"dmagnetic_"$OLD_RELEASE"_to_"$NEW_RELEASE".patch"

rm Makefile distinfo


echo please mail this patch to OpenBSD: Mail to ports@openbsd.org
echo and sthen@openbsd.org

ls -l *.patch

