#/usr/bin/env python3

import os
ANCIENT_RELEASE=os.environ['ANCIENT_RELEASE']
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
		if (lines[idx].find('SIZE')!=-1 or lines[idx].find('Size')!=-1):
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
		updatefilename(lines,prefix,filename_old,filename_new)
		updatesize(lines,prefix,filename_old,filename_new)
		updatechecksums(lines,prefix,filename_old,filename_new)
		updateversion(lines,prefix,'PORTVERSION=',OLD_RELEASE,NEW_RELEASE)

		file=open('new/'+fu,'w')
		for l in lines:
			file.write(l)
		file.close()
		
				
	
def gettimestamp():
		
	daynames=['Mon','Tue','Wed','Thu','Fri','Sat','Sun']
	monthnames=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
	now=datetime.now()
	d=now.day
	m=monthnames[now.month-1]
	y=now.year
	mydate=f'{d:02d} {m} {y:04d}'

	h=now.hour
	m=now.minute
	s=now.second
	mytime=f'{h:02d}:{m:02d}:{s:02d}'

	ts=daynames[now.weekday()]
	ts+=', '
	ts+=mydate
	ts+=' '
	ts+=mytime
	ts+=' +0100'

	return ts


def update_debian(prefix):
	# first: the changelog
	
	filename='debian/changelog'
	createdirectory('new/Debian/'+filename)
	fileo=open('new/Debian/'+filename,'w')
	line='dmagnetic ('+str(NEW_RELEASE)+'-1) unstable; urgency=medium'
	fileo.write(line+'\n')
	line=''
	fileo.write(line+'\n')
	line='  * Update to release '+str(NEW_RELEASE)+'.'
	fileo.write(line+'\n')
	
	filei=open('changelog.new','r')
	lines=filei.readlines()
	filei.close()
	
	for line in lines:
		fileo.write(line+'\n')

	line=' -- Thomas Dettbarn <dettus@dettus.net>  '+gettimestamp()
	fileo.write(line+'\n')
	fileo.write('\n')

	filei=open(prefix+'debian/changelog','r')
	lines=filei.readlines()
	filei.close()
	
	for line in lines:
		fileo.write(line)

	fileo.close()
	


	####
	for files in ['debian/files', 'dput.sh']:
		filei=open(prefix+files)
		lines=filei.readlines()
		filei.close()

		for idx in range(0,len(lines)):
			l=lines[idx].replace('dmagnetic_'+str(OLD_RELEASE),'dmagnetic_'+str(NEW_RELEASE))
			lines[idx]=l
		
		fileo=open('new/Debian/'+files,'w')
		for line in lines:
			fileo.write(line)
		fileo.close()
			
	####
	filei=open(prefix+'debian/upstream/metadata','r')
	lines=filei.readlines()
	filei.close()

	for idx in range(0,len(lines)):
		l=lines[idx].replace('Volume: '+str(OLD_RELEASE),'Volume: '+str(NEW_RELEASE))
		lines[idx]=l

	createdirectory('new/Debian/'+'debian/upstream/metadata')	
	
	fileo=open('new/Debian/'+'debian/upstream/metadata','w')
	for line in lines:
		fileo.write(line)
	fileo.close()


	#### 		
	filei=open(prefix+'mkpackage.sh')
	lines=filei.readlines()
	filei.close()

	for idx in range(0,len(lines)):
		l=lines[idx].replace('VERSION='+str(OLD_RELEASE*100),'VERSION='+str(NEW_RELEASE*100))
		lines[idx]=l

	fileo=open('new/Debian/'+'mkpackage.sh','w')
	for line in lines:
		fileo.write(line)
	fileo.close()
		
	


			

print('updating the ports from '+OLD_RELEASE+' to '+NEW_RELEASE)
prefix="tmp/dettus.net/"
filename_old="dMagnetic_"+OLD_RELEASE+".tar.bz2"
filename_new="dMagnetic_"+NEW_RELEASE+".tar.bz2"


update_OpenBSD()
update_NetBSD()
update_FreeBSD()
update_debian('Debian/games/dmagnetic/')

