#!/bin/bash


date # to make happy :)
echo "***"
echo "*** Please perform the following steps:"
echo "*** [ ] Set up a user 'user'"
echo "*** [ ] Allow root login"
echo "*** [ ] Create one partition, 28G + 4G swap"
echo "*** [ ] Install from ftp.fau.de"
echo "***"
echo "*** Once the installation is finished, reboot the machine, and enter 'openbsd' here"
echo "***"

sh vmscripts/a_run_openbsd.sh 

export H="."

while [ "_"$H != "_openbsd" ]
do
	echo "please enter 'openbsd' when the installation has finished."
	read H
done

echo "***"
echo "*** Patching the virtual machine"
echo "*** Please enter the password for the virtual machine here"
echo "***"

(
	cd vmscripts/patches/openbsd
	tar cvf - * | ssh -p 2001 -l root localhost "( cd / ; tar xvf - )"
)
echo "***"
echo "*** Installing ssh key"
echo "*** Please enter the passwords for the virtual machine here"
echo "***"
(
echo "*** ROOT ***"
 ssh -p 2001 -l root localhost "mkdir -p .ssh"
echo "*** USER ***"
 ssh -p 2001 -l user localhost "mkdir -p .ssh"


echo "*** ROOT ***"
 scp -P 2001 Keys/ssh-keyfile.pub root@localhost:.ssh/authorized_keys
echo "*** USER ***"
 scp -P 2001 Keys/ssh-keyfile.pub user@localhost:.ssh/authorized_keys
)


echo "***"
echo "*** Testing keys"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2001 localhost "id"
ssh -i Keys/ssh-keyfile -l user -p 2001 localhost "id"

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

