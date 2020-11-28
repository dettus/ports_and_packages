#!/usr/bin/env python3
import os
import time
import urllib.request
import shutil
import lzma
import tarfile
from contextlib import closing
prevdebianpackage="dmagnetic_0.27-1"
versionnum="0.28"



####################################################################
###
###
# first: all the hash functions
from datetime import datetime
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


def gettemplatelist(dirtemplate):
	templatefilenames=[]
	templatedirnames=[]
	for (dirpath,dirnames,filenames) in os.walk(dirtemplate):
		for filename in filenames:
			templatefilenames.append(dirpath+"/"+filename)
		for dirname in dirnames:
			templatedirnames.append(dirpath+"/"+dirname)

	return (templatefilenames,templatedirnames)

def mkoutputdirs(templatedirnames,dirtemplate,diroutput):
	os.makedirs(diroutput,exist_ok=True)
	print("creating the output directories:")
	for d in templatedirnames:
		d2=d.replace(dirtemplate,diroutput)
		print(" * "+d2)
		os.makedirs(d2,exist_ok=True)
####################################################################
###
###

def httpfile(dirdownload,url,filename):
	print('downloading '+url+' and writing to '+dirdownload+'/'+filename)
	with urllib.request.urlopen(url) as response,open(dirdownload+'/'+filename,'wb') as out_file:
	        shutil.copyfileobj(response, out_file)





def processfile(filename,dirtemplate,diroutput,macroterminals):
	outputfilename=filename.replace(dirtemplate,diroutput)
	fin=open(filename,'r')
	lines=fin.readlines()
	fin.close()

	processed=""
	for line in lines:
		t1=line
		for k in macroterminals.keys():
			t2=t1.replace(k,macroterminals[k])
			t1=t2
		processed+=t1


	print(" * "+filename+" --> "+outputfilename)
	fout=open(outputfilename,'w')
	fout.write(processed)
	fout.close()


def readTxtFile(filename):
	retval=""
	fin=open(filename)
	lines=fin.readlines()
	fin.close()

	for line in lines:
		retval+=line

	return retval


def patchMakefile(dirdownload,packagename):

	cmdlist='( \n'
	cmdlist+='cd '+dirdownload+' \n'
	cmdlist+='tar xvfj '+packagename+' \n'
	cmdlist+=')\n'
	searchreplace={
		'PREFIX'	: 'DESTDIR',
		'strip ' 	: '#strip ',
		'cp README.txt' : '#cp README.txt',
		'cp LICENSE.txt': '#cp LICENSE.txt'
	}
	os.system(cmdlist)
#	os.system('cd '+dirdownload)
#	os.system('tar xvfj '+packagename);
	os.makedirs(dirdownload+'/a',exist_ok=True)
	os.makedirs(dirdownload+'/b',exist_ok=True)

	cmdlist	
	cmdlist='( \n'
	cmdlist+='cd '+dirdownload+' \n'
	cmdlist+='cp d*/Makefile a/\n'
	cmdlist+=')\n'
	os.system(cmdlist)
	
	fin=open(dirdownload+'/a/Makefile','r')
	lines=fin.readlines()
	fin.close()

	outputline=""
	for line in lines:
		t1=line
		for k in searchreplace.keys():
			t2=t1.replace(k,searchreplace[k])
			t1=t2
		outputline+=t1

	fout=open(dirdownload+'/b/Makefile','w')
	fout.write(outputline)
	fout.close()


	cmdlist='( \n'
	cmdlist+='cd '+dirdownload+' \n'
	cmdlist+='diff -u a/Makefile b/Makefile >makefile.patch\n'
	cmdlist+=')\n'

	os.system(cmdlist)

	retval=readTxtFile(dirdownload+'/makefile.patch')

	return retval


def getnow():

	weekday=('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
	monthname=('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')
	tmstruct=time.localtime()
	now=weekday[tmstruct.tm_wday]+', '
	now+=f'{tmstruct.tm_mday:02d} '+monthname[int(tmstruct.tm_mon)-1]+f' {tmstruct.tm_year:04d} '
	now+=f'{tmstruct.tm_hour:02d}:{tmstruct.tm_min:02d}:{tmstruct.tm_sec:02d} '
	if (tmstruct.tm_isdst==1):
	        now+='+0200'
	else:
	        now+='+0100'

	return now


def downloadfiles(dirrepos,dirdownload,packagefilename):
	print('downloading...')
	os.makedirs(dirrepos,exist_ok=True)
	os.makedirs(dirdownload,exist_ok=True)
	cmdlist='cd '+dirrepos
	cmdlist+='''
		(
			mkdir OpenBSD
			cd OpenBSD
			mkdir -p ports/games/
			cvs -qd anoncvs@anoncvs.ca.openbsd.org:/cvs checkout -P ports/games/dmagnetic
		)
		(
			mkdir -p FreeBSD
			cd FreeBSD
			svn checkout svn://svn.FreeBSD.org/ports/head/games/dMagnetic
		)
		(
			mkdir NetBSD
			cd NetBSD
			cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -P pkgsrc/games/dMagnetic 	
		)
		'''
	os.system(cmdlist)


	url='http://deb.debian.org/debian/pool/main/d/dmagnetic/'+prevdebianpackage+'.debian.tar.xz'
	os.makedirs(dirrepos+"/Debian",exist_ok=True)
	filename=prevdebianpackage+'.debian.tar.xz'
	httpfile(dirrepos+'/Debian',url,filename)
	with lzma.open(dirrepos+'/Debian/'+filename) as f:
		with tarfile.open(fileobj=f) as tar:
			content = tar.extractall(dirrepos+'/Debian')

	url='https://www.dettus.net/dMagnetic/'+packagefilename
	filename=packagefilename
	httpfile(dirdownload,url,filename)
	print('done!')


	

###################################################
dirtemplate="templates"
diroutput="output"
dirdownload="downloads"
dirrepos="repositories"


packagefilename="dMagnetic_"+versionnum+".tar.bz2"
downloadfiles(dirrepos,dirdownload,packagefilename)

(templatefilenames,templatedirnames)=gettemplatelist(dirtemplate)
mkoutputdirs(templatedirnames,dirtemplate,diroutput)

macroterminals={}
macroterminals['%%VERSIONNUM%%']=versionnum
macroterminals['%%FILESIZE%%']=str(os.path.getsize(dirdownload+'/'+packagefilename))
macroterminals['%%TIMESTAMP%%']=str(int(os.stat(dirdownload+'/'+packagefilename).st_mtime))
macroterminals['%%SHA256SUMHEX%%']=mysha256(dirdownload+'/'+packagefilename)
macroterminals['%%SHA256SUMBASE64%%']=mysha256b(dirdownload+'/'+packagefilename)
macroterminals['%%SHA1SUMHEX%%']=mysha1(dirdownload+'/'+packagefilename)
macroterminals['%%RMD160SUMHEX%%']=myrmd160(dirdownload+'/'+packagefilename)
macroterminals['%%SHA512SUMHEX%%']=mysha512(dirdownload+'/'+packagefilename)
macroterminals['%%OLDCHANGELOG%%']=readTxtFile("repositories/Debian/debian/changelog")
macroterminals['%%NEWCHANGELOG%%']="dmagnetic ("+versionnum+"-1) unstable; urgency=medium\n\n"+readTxtFile("newchangelog.txt")+"\n -- Thomas Dettbarn <dettus@dettus.net>  "+getnow()
macroterminals['%%DEBIANMAKEFILEPATCH%%']='Transform the BSD-style Makefile into Debian-style\n'+patchMakefile(dirdownload,packagefilename)


##for k in macroterminals.keys():
##	print(k+":"+macroterminals[k])

print('processing files')
for filename in templatefilenames:
	processfile(filename,dirtemplate,diroutput,macroterminals)


print('-----------------------')
print(f'this was version {versionnum}')
print('The changelog is:')
print(macroterminals['%%NEWCHANGELOG%%'])
print('-----------------------')
print('if you are satisfied, run sh diff.sh')
