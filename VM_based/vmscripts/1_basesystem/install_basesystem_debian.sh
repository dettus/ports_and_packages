#!/bin/bash


date	# to make happy :) 
echo "***"
echo "*** Please perform the following steps:"
echo "*** [ ] Change the /etc/ssh/sshd_config to say PermitRootLogin yes"
echo "*** Once the installation is finished, reboot the machine, and enter 'debian' here"
echo "***"

sh vmscripts/3_run/d_run_debian.sh

export H="."

while [  "_"$H != "_debian" ]
do
	echo "please enter 'debian' when the installation has finished."
	read H
done

echo "***"
echo "*** Patching the virtual machine"
echo "*** Please enter the password for the virtual machine here"
echo "***"

(
	cd vmscripts/patches/debian
	tar cvf - * | ssh -p 2004 -l root localhost "( cd / ; tar xvf - )"
)
echo "***"
echo "*** Installing ssh key"
echo "*** Please enter the passwords for the virtual machine here"
echo "***"
(
echo "*** ROOT ***"
 ssh -p 2004 -l root localhost "mkdir -p .ssh"
echo "*** USER ***"
 ssh -p 2004 -l user localhost "mkdir -p .ssh"


echo "*** ROOT ***"
 scp -P 2004 Keys/ssh-keyfile.pub root@localhost:.ssh/authorized_keys
echo "*** USER ***"
 scp -P 2004 Keys/ssh-keyfile.pub user@localhost:.ssh/authorized_keys
)


echo "***"
echo "*** Testing keys"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2004 localhost "id"
ssh -i Keys/ssh-keyfile -l user -p 2004 localhost "id"


echo "***"
echo "*** Installation done. Shutting VM down"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2004 localhost "/usr/sbin/halt -p"

