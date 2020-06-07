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


def updateversion(lines,prefix,keyword,version_old,version_new):
	for idx in range(0,len(lines)):
		if (lines[idx].find(keyword)!=-1):
			l=lines[idx].replace(version_old,version_new)
			lines[idx]=l

	

def updatefilename(lines,prefix,filename_old,filename_new):
	for idx in range(0,len(lines)):
		l=lines[idx].replace(filename_old,filename_new)
		lines[idx]=l

def calcchecksums(filename):
	checksums={}
	
	checksums['md5'     ]=mymd5(filename)
	checksums['sha1'    ]=mysha1(filename)
	checksums['rmd160'  ]=myrmd160(filename)
	checksums['sha256'  ]=mysha256(filename)
	checksums['sha256b' ]=mysha256b(filename)
	checksums['sha512'  ]=mysha512(filename)

	return checksums

	
def updatechecksums(lines,prefix,filename_old,filename_new):
	checksums_old=calcchecksums(prefix+filename_old)
	checksums_new=calcchecksums(prefix+filename_new)

	for idx in range(0,len(lines)):
		l=lines[idx]
		for k in checksums_old.keys():
			l2=l.replace(checksums_old[k],checksums_new[k])
			l=l2
		lines[idx]=l



def updatedotest(lines,prefix):
	minitest_old={}
	minitest_new={}	
	for mode in ['none', 'monochrome','monochrome_inv','low_ansi','low_ansi2','high_ansi','high_ansi2','sixel']:
		
		filename_old=prefix+'minitest_'+OLD_RELEASE+'_'+mode+'.log'
		filename_new=prefix+'minitest_'+NEW_RELEASE+'_'+mode+'.log'

		minitest_old[mode]=calcchecksums(filename_old)
		minitest_new[mode]=calcchecksums(filename_new)

		for idx in range(0,len(lines)):
			l=lines[idx]
			for k in minitest_old[mode].keys():
				l2=l.replace(minitest_old[mode][k],minitest_new[mode][k])
				l=l2
			lines[idx]=l



def createdirectory(filename):
	name=''
	s=filename.split('/')
	for d in range(0,len(s)-1):
		name=name+s[d]+'/'

	try:
		os.makedirs(name)
	except:
		print('directory exists')


def update_OpenBSD():
	prefix='tmp/dettus.net/'
	filename_old="dMagnetic_"+OLD_RELEASE+".tar.bz2"
	filename_new="dMagnetic_"+NEW_RELEASE+".tar.bz2"
	filestoupdate=[]
	filestoupdate.append('OpenBSD/ports/games/dmagnetic/Makefile')
	filestoupdate.append('OpenBSD/ports/games/dmagnetic/distinfo')
	
	for fu in filestoupdate:
		createdirectory('new/'+fu)
		file=open('tmp/'+fu,'r')
		lines=file.readlines()
		file.close
		
		# TODO: do-test
		updatedotest(lines,prefix)
		updatefilename(lines,prefix,filename_old,filename_new)
		updatesize(lines,prefix,filename_old,filename_new)
		updatechecksums(lines,prefix,filename_old,filename_new)
		updateversion(lines,prefix,'V =',OLD_RELEASE,NEW_RELEASE)

		file=open('new/'+fu,'w')
		for l in lines:
			file.write(l)
		file.close()
		
				
		
	
def update_NetBSD():
	prefix='tmp/dettus.net/'
	filename_old="dMagnetic_"+OLD_RELEASE+".tar.bz2"
	filename_new="dMagnetic_"+NEW_RELEASE+".tar.bz2"
	filestoupdate=[]
	filestoupdate.append('NetBSD/pkgsrc/games/dMagnetic/Makefile')
	filestoupdate.append('NetBSD/pkgsrc/games/dMagnetic/distinfo')
	
	for fu in filestoupdate:
		createdirectory('new/'+fu)
		file=open('tmp/'+fu,'r')
		lines=file.readlines()
		file.close
		
		# TODO: do-test
		updatedotest(lines,prefix)
		updatefilename(lines,prefix,filename_old,filename_new)
		updatesize(lines,prefix,filename_old,filename_new)
		updatechecksums(lines,prefix,filename_old,filename_new)
		updateversion(lines,prefix,'DISTNAME=',OLD_RELEASE,NEW_RELEASE)

		file=open('new/'+fu,'w')
		for l in lines:
			file.write(l)
		file.close()

		
def update_FreeBSD():
	prefix='tmp/dettus.net/'
	filename_old="dMagnetic_"+OLD_RELEASE+".tar.bz2"
	filename_new="dMagnetic_"+NEW_RELEASE+".tar.bz2"
	filestoupdate=[]
	filestoupdate.append('FreeBSD/ports/games/dMagnetic/Makefile')
	filestoupdate.append('FreeBSD/ports/games/dMagnetic/distinfo')
	
	for fu in filestoupdate:
		createdirectory('new/'+fu)
		file=open('tmp/'+fu,'r')
		lines=file.readlines()
		file.close
		
		# TODO: do-test
		updatedotest(lines,prefix)
		updatefilename(lines,prefix,filename_old,filename_new)
		updatesize(lines,prefix,filename_old,filename_new)
		updatechecksums(lines,prefix,filename_old,filename_new)
		updateversion(lines,prefix,'PORTVERSION=',OLD_RELEASE,NEW_RELEASE)

		file=open('new/'+fu,'w')
		for l in lines:
			file.write(l)
		file.close()
		
				
		
		

print('updating the ports from '+OLD_RELEASE+' to '+NEW_RELEASE)
prefix="tmp/dettus.net/"
filename_old="dMagnetic_"+OLD_RELEASE+".tar.bz2"
filename_new="dMagnetic_"+NEW_RELEASE+".tar.bz2"


update_OpenBSD()
update_NetBSD()
update_FreeBSD()

