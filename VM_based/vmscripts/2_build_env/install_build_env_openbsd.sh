#!/bin/bash


date # to make happy :)
pwd
bash vmscripts/3_run/a_run_openbsd.sh 
sleep 120

echo "***"
echo "*** Installing packages"
echo "***"

ssh -i Keys/ssh-keyfile -l root -p 2001 localhost "pkg_add git"
ssh -i Keys/ssh-keyfile -l root -p 2001 localhost "pkg_add git"
ssh -i Keys/ssh-keyfile -l root -p 2001 localhost "pkg_add bzip2"
ssh -i Keys/ssh-keyfile -l root -p 2001 localhost "pkg_add bzip2"
ssh -i Keys/ssh-keyfile -l root -p 2001 localhost "cd /usr"
ssh -i Keys/ssh-keyfile -l root -p 2001 localhost "git clone https://github.com/openbsd/ports"

echo "***"
echo "*** Installation done. Shutting VM down"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2001 localhost "/sbin/halt -p"

