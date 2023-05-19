#!/bin/bash

date	# to make happy :) 
echo "***"
echo "*** Please perform the following steps:"
echo "*** [ ] e/c: CONFIGURE THE NETWORK"
echo "*** [ ] d: Change root password"
echo "*** [ ] g: Enable sshd"
echo "*** [ ] o: Add a user (add to group wheel)"
echo "*** [ ] Change the /etc/ssh/sshd_config to say PermitRootLogin yes"
echo "*** Once the installation is finished, reboot the machine, and enter 'netbsd' here"
echo "***"

sh vmscripts/3_run/c_run_netbsd.sh 

export H="."

while [  "_"$H != "_netbsd" ]
do
	echo "please enter 'netbsd' when the installation has finished."
	read H
done

echo "***"
echo "*** Patching the virtual machine"
echo "*** Please enter the password for the virtual machine here"
echo "***"

(
	cd vmscripts/patches/netbsd
	tar cvf - * | ssh -p 2003 -l root localhost "( cd / ; tar xvf - )"
)
echo "***"
echo "*** Installing ssh key"
echo "*** Please enter the passwords for the virtual machine here"
echo "***"
(
 echo "*** ROOT ***"
 ssh -p 2003 -l root localhost "mkdir -p .ssh"
 echo "*** USER ***"
 ssh -p 2003 -l user localhost "mkdir -p .ssh"


 echo "*** ROOT ***"
 scp -P 2003 Keys/ssh-keyfile.pub root@localhost:.ssh/authorized_keys
 ssh -p 2003 -l root localhost "/sbin/chown -R root:wheel /root"
 echo "*** USER ***"
 scp -P 2003 Keys/ssh-keyfile.pub user@localhost:.ssh/authorized_keys
)


echo "***"
echo "*** Testing keys"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "id"
ssh -i Keys/ssh-keyfile -l user -p 2003 localhost "id"


echo "***"
echo "*** Installation done. Shutting VM down"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2003 localhost "/sbin/halt -p"

