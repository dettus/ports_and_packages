#!/usr/bin/env python3

from os import walk

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



for (dirpath,dirnames,filenames) in walk("templates/"):
	for filename in filenames:
		processfile(dirpath,filename)
