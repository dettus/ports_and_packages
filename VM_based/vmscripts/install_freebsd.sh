#!/bin/bash



sudo date	# to make sudo happy :) 
echo "***"
echo "*** Please perform the following steps:"
echo "*** [ ] Set up a root password"
echo "*** [ ] Set up a user, INVITE to group 'wheel'"
echo "*** [ ] Change the /etc/ssh/sshd_config so that it PermitRootLogin yes is active"
echo "*** Once the installation is finished, reboot the machine, and enter 'freebsd' here"
echo "***"

sudo  sh vmscripts/b_run_freebsd.sh 

export H="."

while [  "_"$H != "_freebsd" ]
do
	echo "please enter 'freebsd' when the installation has finished."
	read H
done

echo "***"
echo "*** Patching the virtual machine"
echo "*** Please enter the password for the virtual machine here"
echo "***"

(
	cd vmscripts/patches/freebsd
	tar cvf - * | ssh -p 2002 -l root localhost "( cd / ; tar xvf - )"
)
echo "***"
echo "*** Installing ssh key"
echo "*** Please enter the passwords for the virtual machine here"
echo "***"
(
 ssh -p 2002 -l root localhost "mkdir -p .ssh"
 ssh -p 2002 -l user localhost "mkdir -p .ssh"


 scp -P 2002 Keys/ssh-keyfile.pub root@localhost:.ssh/authorized_keys
 scp -P 2002 Keys/ssh-keyfile.pub user@localhost:.ssh/authorized_keys
)


echo "***"
echo "*** Testing keys"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2002 localhost "id"
ssh -i Keys/ssh-keyfile -l user -p 2002 localhost "id"


echo "***"
echo "*** Installation done. Shutting VM down"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2002 localhost "/sbin/halt -p"

