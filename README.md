# ports_and_packages
Ports and Packages that can be used in various Operating Systems to install my projects.


TO UPDATE:

FreeBSD: bugzilla
svn checkout svn://svn.FreeBSD.org/ports/head/games
1. sha256sum dMagnetic_0.16.tar.gz
2. ls -l dMagnetic_0.16.tar.gz
3. update distinfo and makefile
4. diff -u Makefile.orig Makefile >>dMagnetic_015_to_16.patch
5. diff -u distinfo distinfo >>dMagnetic_015_to_016.patch

go to https://bugs.freebsd.org/bugzilla/, upload it and attach the patch.

"setting the maintainer-approval flag to + on the submitted patch will speed
up the processing/triggering".


OpenBSD: Mail to ports@openbsd.org
cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports
1. sha256sum dMagnetic_0.16.tar.gz
2. ls -l dMagnetic_0.16.tar.gz
3. update distinfo and makefile
4. diff -u Makefile.orig Makefile >>dMagnetic_015_to_16.patch
5. diff -u distinfo distinfo >>dMagnetic_015_to_016.patch



