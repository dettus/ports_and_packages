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

dput mentors dmagnetic_0.17-3_amd64.changes

