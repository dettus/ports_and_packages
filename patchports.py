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


def updatesize(lines,prefix,filename_old,filename_new):
	filesize_old=str(os.path.getsize(prefix+filename_old))
	filesize_new=str(os.path.getsize(prefix+filename_new))
	for idx in range(0,len(lines)):
		if (lines[idx].find('SIZE')!=-1):
			l=lines[idx].replace(filesize_old,filesize_new)
			lines[idx]=l



def updatefilename(lines,prefix,filename_old,filename_new):
	for idx in range(0,len(lines)):
		l=lines[idx].replace(filename_old,filename_new)
		lines[idx]=l

	
	
def updatechecksums(lines,prefix,filename_old,filename_new):
	checksums_old={}
	checksums_new={}


	checksums_old['md5'     ]=mymd5(prefix+filename_old)
	checksums_old['sha1'    ]=mysha1(prefix+filename_old)
	checksums_old['rmd160'  ]=myrmd160(prefix+filename_old)
	checksums_old['sha256'  ]=mysha256(prefix+filename_old)
	checksums_old['sha256b' ]=mysha256b(prefix+filename_old)
	checksums_old['sha512'  ]=mysha512(prefix+filename_old)

	checksums_new['md5'     ]=mymd5(prefix+filename_new)
	checksums_new['sha1'    ]=mysha1(prefix+filename_new)
	checksums_new['rmd160'  ]=myrmd160(prefix+filename_new)
	checksums_new['sha256'  ]=mysha256(prefix+filename_new)
	checksums_new['sha256b' ]=mysha256b(prefix+filename_new)
	checksums_new['sha512'  ]=mysha512(prefix+filename_new)

	for idx in range(0,len(lines)):
		l=lines[idx]
		for k in checksums_old.keys():
			l2=l.replace(checksums_old[k],checksums_new[k])
			l=l2
		lines[idx]=l
		

print('updating the ports from '+OLD_RELEASE+' to '+NEW_RELEASE)
prefix="tmp/dettus.net/"
filename_old="dMagnetic_"+OLD_RELEASE+".tar.bz2"
filename_new="dMagnetic_"+NEW_RELEASE+".tar.bz2"


file=open('tmp/OpenBSD/ports/games/dmagnetic/distinfo')
lines=file.readlines()
file.close()

print('----- old ----')
for line in lines:
	print(line,end='')

updatefilename(lines,prefix,filename_old,filename_new)
updatesize(lines,prefix,filename_old,filename_new)
updatechecksums(lines,prefix,filename_old,filename_new)
print('----- new ----')
for line in lines:
	print(line,end='')
'''
try:
	os.makedirs('new/openBSD/ports/games/')
except:
'''
