#!/bin/sh

vi versionnumber.txt
vi newchangelog.txt
python3 mkrepositories.py
sh diff.sh

