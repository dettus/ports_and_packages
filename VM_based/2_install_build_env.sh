#!/bin/bash


date
bash vmscripts/2_build_env/install_build_env_debian.sh
date
bash vmscripts/2_build_env/install_build_env_freebsd.sh
date
bash vmscripts/2_build_env/install_build_env_netbsd.sh
date
bash vmscripts/2_build_env/install_build_env_openbsd.sh
date
