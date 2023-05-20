#!/bin/bash

date	# to make happy :) 
pwd
bash vmscripts/3_run/c_run_netbsd.sh 
sleep 120
echo "***"
echo "*** Installing packages"
echo "***"

ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "env PKG_PATH=http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/x86_64/9.3/All /usr/sbin/pkg_add doas pkgdiff git"
#ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "cd /usr && cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -P pkgsrc"
ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "cd /usr && git -c http.sslVerify=false clone https://github.com/netbsd/pkgsrc"

echo "***"
echo "*** Installation done. Shutting VM down"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "/sbin/halt -p"

