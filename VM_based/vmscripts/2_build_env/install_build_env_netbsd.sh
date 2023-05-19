#!/bin/bash

date	# to make happy :) 
sh vmscripts/3_run/c_run_netbsd.sh 
sleep 73
echo "***"
echo "*** Installing packages"
echo "***"

ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "/usr/sbin/pkg_add doas"
ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "/usr/sbin/pkg_add pkgdiff"
ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "/usr/sbin/pkg_add git"
#ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "cd /usr && cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -P pkgsrc"
ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "cd /usr && git -c http.sslVerify=false clone https://github.com/netbsd/pkgsrc"

echo "***"
echo "*** Installation done. Shutting VM down"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "/sbin/halt -p"

