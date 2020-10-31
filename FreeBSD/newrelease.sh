#!/bin/sh

export OLD_RELEASE=0.25
export NEW_RELEASE=0.26

mkdir svnserver
cd svnserver
svn checkout svn://svn.FreeBSD.org/ports/head/games
rm -rf games/dMagnetic/*
cp -r ../games/dMagnetic/* games/dMagnetic
cd ..
svn diff svnserver/games/dMagnetic >"dMagnetic_"$OLD_RELEASE"_"$NEW_RELEASE".diff"
echo "in python:"
echo "import datetime"
echo "d=datetime.datetime(2020,7,26,14,12,0)"
echo "d.timestamp()"
echo
echo "-----------------------------------------------------"
echo "submit the port via https://bugs.freebsd.org/submit/"
echo "please read https://www.freebsd.org/doc/en_US.ISO8859-1/books/porters-handbook/porting-submitting.html"



