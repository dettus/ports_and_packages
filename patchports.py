#/usr/bin/env python3

import os
OLD_RELEASE=os.environ['OLD_RELEASE']
NEW_RELEASE=os.environ['NEW_RELEASE']

from datetime import datetime;
import hashlib
import base64
from Crypto.Hash import RIPEMD
def mymd5(fname):
	hash_md5 = hashlib.md5()
	with open(fname, "rb") as f:
		for chunk in iter(lambda: f.read(4096), b""):
			hash_md5.update(chunk)
	return hash_md5.hexdigest()


def mysha1(fname):
	hash_sha1 = hashlib.sha1()
	with open(fname, "rb") as f:
		for chunk in iter(lambda: f.read(4096), b""):
			hash_sha1.update(chunk)
	return hash_sha1.hexdigest()

def mysha256(fname):
	hash_sha256 = hashlib.sha256()
	with open(fname, "rb") as f:
		for chunk in iter(lambda: f.read(4096), b""):
			hash_sha256.update(chunk)
	return hash_sha256.hexdigest()

def mysha256b(fname):
	hash_sha256 = hashlib.sha256()
	with open(fname, "rb") as f:
		for chunk in iter(lambda: f.read(4096), b""):
			hash_sha256.update(chunk)
	return base64.standard_b64encode(hash_sha256.digest()).decode()

def mysha512(fname):
	hash_sha512 = hashlib.sha512()
	with open(fname, "rb") as f:
		for chunk in iter(lambda: f.read(4096), b""):
			hash_sha512.update(chunk)
	return hash_sha512.hexdigest()

def myrmd160(fname):
	hash_rmd160=RIPEMD.new()
	with open(fname, "rb") as f:
		for chunk in iter(lambda: f.read(4096), b""):
			hash_rmd160.update(chunk)
	return hash_rmd160.hexdigest()
	

print('updating the ports from '+OLD_RELEASE+' to '+NEW_RELEASE)
filename_old="tmp/dMagnetic_"+OLD_RELEASE+".tar.bz2"
filename_new="tmp/dMagnetic_"+NEW_RELEASE+".tar.bz2"

print('md5:    '+mymd5(filename_old))
print('sha1:   '+mysha1(filename_old))
print('sha256: '+mysha256(filename_old))
print('sha256b:'+mysha256b(filename_old))
print('sha512: '+mysha512(filename_old))
print('rmd160: '+myrmd160(filename_old))

