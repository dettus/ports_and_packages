#!/usr/bin/env python3
import os
versionnum="0.28"


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


def getOldDebianChangelog(filename):
	retval=""
	fin=open(filename)
	lines=fin.readlines()
	fin.close()

	for line in lines:
		retval+=line

	return retval

	

print("\x1b[0;31m TODO: ASK FOR THE CORRECT VERSION NUMBER \x1b[0m");
print("\x1b[1;31m TODO: DOWNLOAD THE REPOSITORIES \x1b[0m")
print("\x1b[1;31m TODO: DOWNLOAD THE dMangetic file\x1b[0m")
###################################################
dirtemplate="templates"
diroutput="output"
dirdownload="downloads"
packagefilename=dirdownload+"/dMagnetic_"+versionnum+".tar.bz2"

(templatefilenames,templatedirnames)=gettemplatelist(dirtemplate)
mkoutputdirs(templatedirnames,dirtemplate,diroutput)

macroterminals={}
macroterminals['%%VERSIONNUM%%']=versionnum
macroterminals['%%FILESIZE%%']=str(os.path.getsize(packagefilename))
macroterminals['%%TIMESAMP%%']=str(int(os.stat(packagefilename).st_mtime))
macroterminals['%%SHA256SUMHEX%%']=mysha256(packagefilename)
macroterminals['%%SHA256SUMBASE64%%']=mysha256b(packagefilename)
macroterminals['%%SHA1SUMHEX%%']=mysha1(packagefilename)
macroterminals['%%RMD160SUMHEX%%']=myrmd160(packagefilename)
macroterminals['%%SHA512SUMHEX%%']=mysha512(packagefilename)
macroterminals['%%OLDCHANGELOG%%']=getOldDebianChangelog("repositories/Debian/debian/changelog")


##for k in macroterminals.keys():
##	print(k+":"+macroterminals[k])

print('processing files')
for filename in templatefilenames:
	processfile(filename,dirtemplate,diroutput,macroterminals)

