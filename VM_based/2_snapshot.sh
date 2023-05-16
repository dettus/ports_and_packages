#!/bin/sh

export NOW=`date +%Y%m%d_%H%M%S`
date
tar cvfj snapshot_$NOW.tar.bz2 Images/
date
