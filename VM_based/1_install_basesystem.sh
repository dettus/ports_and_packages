#!/bin/sh

date 

bash vmscripts/1_basesystem/install_basesystem_openbsd.sh
bash vmscripts/1_basesystem/install_basesystem_freebsd.sh
bash vmscripts/1_basesystem/install_basesystem_netbsd.sh
bash vmscripts/1_basesystem/install_basesystem_debian.sh

date

