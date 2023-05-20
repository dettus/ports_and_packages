#!/bin/bash


date	# to make happy :) 
pwd
bash vmscripts/3_run/d_run_debian.sh
sleep 120
echo "***"
echo "*** Installing packages"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2004 localhost "apt-get -y update"
ssh -i Keys/ssh-keyfile -l root -p 2004 localhost "DEBIAN_FRONTEND=noninteractive  apt-get -y install devscripts build-essential"
scp -i Keys/ssh-keyfile -P 2004 -r /home/dettus/.gnupg user@localhost:
#ssh -i Keys/ssh-keyfile -l root -p 2004 localhost "( echo 'yes' ; echo '2' ) | apt -y upgrade"
#ssh -i Keys/ssh-keyfile -l root -p 2004 localhost "apt -y install apt-file doas"
#ssh -i Keys/ssh-keyfile -l root -p 2004 localhost "apt-file update"

echo "***"
echo "*** Installation done. Shutting VM down"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2004 localhost "/usr/sbin/halt -p"

