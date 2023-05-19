#!/bin/sh


ssh -i ../../VM_based/Keys/ssh-keyfile -p 2001 root@localhost "chmod 755 4_inside_vm.sh"
ssh -i ../../VM_based/Keys/ssh-keyfile -p 2002 root@localhost "chmod 755 4_inside_vm.sh"
ssh -i ../../VM_based/Keys/ssh-keyfile -p 2003 root@localhost "chmod 755 4_inside_vm.sh"
ssh -i ../../VM_based/Keys/ssh-keyfile -p 2004 user@localhost "chmod 755 4_inside_vm.sh"

ssh -i ../../VM_based/Keys/ssh-keyfile -p 2001 root@localhost "sh ./4_inside_vm.sh"
ssh -i ../../VM_based/Keys/ssh-keyfile -p 2002 root@localhost "sh ./4_inside_vm.sh"
ssh -i ../../VM_based/Keys/ssh-keyfile -p 2003 root@localhost "sh ./4_inside_vm.sh"
ssh -i ../../VM_based/Keys/ssh-keyfile -p 2004 user@localhost "sh ./4_inside_vm.sh"


scp -i ../../VM_based/Keys/ssh-keyfile -P 2001 root@localhost:package_out.patch openbsd_dmagnetic037.patch
scp -i ../../VM_based/Keys/ssh-keyfile -P 2002 root@localhost:package_out.patch freebsd_dmagnetic037.patch
scp -i ../../VM_based/Keys/ssh-keyfile -P 2003 root@localhost:package_out.patch netbsd_dmagnetic037.patch


ls -l *.patch
echo "*** You might want to connect to the debian VM and run dput.sh"
