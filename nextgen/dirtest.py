#!/usr/bin/env python3
import os

def processfile(dirpath,filename):
	fullname=dirpath+'/'+filename;
	print(f"Processing file \x1b[0;32m{fullname:s}\x1b[0m")
	fin=open(fullname,'r')
	lines=fin.readlines()
	fin.close()


	fulloutname="/tmp/det/"+filename
	outputline=""
	for line in lines:
		outputline+=line
		print(line)
	fout=open(fulloutname,"w")
	fout.write(outputline)
	fout.close()




fullfilenames=[]
fulldirnames=[]
for (dirpath,dirnames,filenames) in os.walk("templates/"):
	for filename in filenames:
		fullfilenames.append(dirpath+"/"+filename)
	for dirname in dirnames:
		fulldirnames.append(dirpath.replace("templates","output")+"/"+dirname)


os.mkdir("output")
print("create the following directories:")
for d in fulldirnames:
	print(d)
	os.mkdir(d)

print("process the following files:")
for f in fullfilenames:
	print(f)
