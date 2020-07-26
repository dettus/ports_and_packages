#!/bin/sh


echo "
[mentors]
fqdn = mentors.debian.net
incoming = /upload
method = https
allow_unsigned_uploads = 0
progress_indicator = 2
# Allow uploads for UNRELEASED packages
allowed_distributions = .*
" >$HOME/.dput.cf

dput --force mentors dmagnetic_0.25-1_amd64.changes

