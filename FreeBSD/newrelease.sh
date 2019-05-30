#!/bin/sh

mkdir svnserver
cd svnserver
svn checkout svn://svn.FreeBSD.org/ports/head/games
rm -rf games/dMagnetic/*
cp -r ../games/dMagnetic/* games/dMagnetic
cd ..
svn diff svnserver/games/dMagnetic >dMagnetic.diff

echo
echo "-----------------------------------------------------"
echo "submit the port via https://bugs.freebsd.org/submit/"
echo "please read https://www.freebsd.org/doc/en_US.ISO8859-1/books/porters-handbook/porting-submitting.html"

