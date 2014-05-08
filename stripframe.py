import glob
import os
import shutil


#Just change directory on line 11 to cut frames

def getfilelist(f=None):
	"""Reads in meta data"""
	if (f==None):
		os.chdir("data/5/")
		kin = []
		meta = []
		accel = []

		for file in glob.glob("kin_*.txt"):
			kin.append(file)
		for file in glob.glob("meta_*.txt"):
			meta.append(file)
		for file in glob.glob("accel_*.txt"):
			accel.append(file)

	#print "Kin is: "+str(kin)
	#print "Meta is: "+str(meta)
	return (kin,meta,accel)


def framecut(f):
	FCUT = 270;
	"""cut out beginning and end frames"""
	kindata = open(f[0],'r')
	lines = kindata.readlines()
	kindata.close()
	flength = len(lines)
	print flength
	lines = lines[FCUT:(flength-FCUT)]
	# lines = lines[FCUT::]
	flength = len(lines)
	print flength
	kindata = open(f[0],'w')
	for line in lines:
		kindata.write(line);
	kindata.close


if __name__ == '__main__':
	print  "Cleaning Kinect Frame Data...."
	kin,meta,accel = getfilelist()
	framecut(kin)