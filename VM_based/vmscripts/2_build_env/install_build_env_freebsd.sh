#!/bin/bash

date	# to make happy :) 
pwd
bash vmscripts/3_run/b_run_freebsd.sh 
sleep 120
echo "***"
echo "*** Installing packages"
echo "***"

ssh -i Keys/ssh-keyfile -l root -p 2002 localhost "env ASSUME_ALWAYS_YES=yes pkg install git bzip2"
ssh -i Keys/ssh-keyfile -l root -p 2002 localhost "cd /usr ; git clone https://github.com/freebsd/freebsd-ports ports"



echo "***"
echo "*** Installation done. Shutting VM down"
echo "***"
ssh -i Keys/ssh-keyfile -l root -p 2002 localhost "/sbin/halt -p"

