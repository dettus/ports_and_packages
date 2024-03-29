#!/usr/bin/env python3 -i
import os
import shutil
import sys

versionnum=sys.argv[1]
macros={
	"%%VERSIONNUMBERHERE%%":versionnum
}



def makepackage(portsdir):
	template_dirs= []
	template_files=[]
	for (dirpath, dirnames, filenames) in os.walk(portsdir+"/templates/"):
		for d in dirnames:
			template_dirs.append(dirpath+"/"+str(d))
		for f in filenames:
			template_files.append(dirpath+"/"+str(f))


	print(portsdir+">> creating output directories")

	shutil.rmtree(portsdir+"/PACKAGE_IN",ignore_errors=True)
	os.makedirs(portsdir+"/PACKAGE_IN")
	for d in template_dirs:
		newdir=d.replace("/templates/","/PACKAGE_IN/")
		os.makedirs(newdir)


	print(portsdir+">> creating package files")
	for name_in in template_files:
		name_out=name_in.replace("/templates/","/PACKAGE_IN/")
		f_in=open(name_in,"r")
		f_out=open(name_out,"w")

		lines_in=f_in.readlines()
		lines_out=[]
		for l in lines_in:
			tmp1=l
			for m in macros.keys():
				tmp2=tmp1.replace(str(m),str(macros[m]))
				tmp1=tmp2
				
			lines_out.append(tmp1)

		f_out.writelines(lines_out)
		f_in.close()
		f_out.close()

	basedir=portsdir+"/PACKAGE_IN"
	rootdir=portsdir+"/PACKAGE_IN"
	rootdir="."
	shutil.make_archive(portsdir+"/PACKAGE_IN","gztar",basedir,rootdir)



def makepatch(portsdir):
	basedir=portsdir+"/patches_0.37"
	rootdir="."
	try:
		shutil.make_archive(portsdir+"/PATCHES_IN","gztar",basedir,rootdir)
	except:
		pass


shutil.copy("changelog","ports/Debian/templates/debian/")

for ports in ["OpenBSD","FreeBSD","NetBSD","Debian"]:
	makepackage("ports/"+ports)

for ports in ["OpenBSD","FreeBSD","NetBSD"]:
	makepatch("ports/"+ports)

