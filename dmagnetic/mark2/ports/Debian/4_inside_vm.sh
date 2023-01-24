#!/bin/sh

rm -rf tmp
mkdir tmp
cd tmp
tar xvfz ../PACKAGE_IN.tar.gz
sh mkpackage.sh

