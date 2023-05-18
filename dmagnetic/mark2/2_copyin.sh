#!/bin/bash

scp -i ../../VM_based/Keys/ssh-keyfile -P 2001 ports/OpenBSD/PACKAGE_IN.tar.gz root@localhost:
scp -i ../../VM_based/Keys/ssh-keyfile -P 2001 ports/OpenBSD/PATCHES_IN.tar.gz root@localhost:
scp -i ../../VM_based/Keys/ssh-keyfile -P 2001 ports/OpenBSD/4_inside_vm.sh root@localhost:

scp -i ../../VM_based/Keys/ssh-keyfile -P 2002 ports/FreeBSD/PACKAGE_IN.tar.gz root@localhost:
scp -i ../../VM_based/Keys/ssh-keyfile -P 2002 ports/FreeBSD/4_inside_vm.sh root@localhost:

scp -i ../../VM_based/Keys/ssh-keyfile -P 2003 ports/NetBSD/PACKAGE_IN.tar.gz root@localhost:
scp -i ../../VM_based/Keys/ssh-keyfile -P 2003 ports/NetBSD/4_inside_vm.sh root@localhost:

scp -i ../../VM_based/Keys/ssh-keyfile -P 2004 ports/Debian/PACKAGE_IN.tar.gz user@localhost:
scp -i ../../VM_based/Keys/ssh-keyfile -P 2004 ports/Debian/4_inside_vm.sh user@localhost:


