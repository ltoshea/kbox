import glob
import os
import shutil

def getfilelist(f=None):
	"""Reads in meta data"""
	if (f==None):
		os.chdir(".")
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


def dirbuild():
	"Builds data directory tree"

	origpath=os.getcwd()+"/data"
	if not os.path.exists(origpath): 
		print ('Creating Data Directory')
		os.makedirs(origpath)
	
	newpath=origpath+"/1"
	if not os.path.exists(newpath): 
		print ('Creating Jab Directory')
		os.makedirs(newpath)
	
	newpath=origpath+"/2"
	if not os.path.exists(newpath): 
		print ('Creating Cross Directory')
		os.makedirs(newpath)
	
	newpath=origpath+"/3"
	if not os.path.exists(newpath): 
		print ('Creating Lhook Directory')
		os.makedirs(newpath)
	
	newpath=origpath+"/4"
	if not os.path.exists(newpath): 
		print ('Creating Rhook Directory')
		os.makedirs(newpath)
	
	newpath=origpath+"/5"
	if not os.path.exists(newpath): 
		print ('Creating Luppercut Directory')
		os.makedirs(newpath)
	
	newpath=origpath+"/6"
	if not os.path.exists(newpath): 
		print ('Creating Ruppercut Directory')
		os.makedirs(newpath)

	newpath=origpath+"/unknown"
	if not os.path.exists(newpath): 
		print ('Creating Unknown Directory')
		os.makedirs(newpath)


def datasort(f):
	"Sorts meta,kin,accel into correct data folders"
	
	jab = []
	cross = []
	lhook = []
	rhook = []
	luppercut = []
	ruppercut = []
	unknown = []
	datadir = os.getcwd()+"/data"

	for i in range (0,len(f)):
		with open(f[i],'r') as finput:
			for line in finput:
				line = line.lower()
				if 'jab' in line:
					print "jab"
					jab.append(f[i])
				elif 'cross' in line:
					print "cross"
					cross.append(f[i])
				elif 'lhook' in line:
					print "lhook"
					lhook.append(f[i])
				elif 'rhook' in line:
					print "rhook"
					rhook.append(f[i])
				elif 'luppercut' in line:
					print 'luppercut'
					luppercut.append(f[i])
				elif 'ruppercut' in line:
					print 'ruppercut'
					ruppercut.append(f[i])
				else:
					print 'unknown meta file: '+str(f[i])
					unknown.append(f[i])
	

	try:
		for f in jab:
			kinf="kin"+str(f[4:])
			accelf="accel"+str(f[4:])
			shutil.move(f,datadir+"/jab")
			shutil.move(kinf,datadir+"/jab")
			shutil.move(accelf,datadir+"/jab")

		for f in cross:
			kinf="kin"+str(f[4:])
			accelf="accel"+str(f[4:])
			shutil.move(f,datadir+"/cross")
			shutil.move(kinf,datadir+"/cross")
			shutil.move(accelf,datadir+"/cross")

		for f in lhook:
			kinf="kin"+str(f[4:])
			accelf="accel"+str(f[4:])
			shutil.move(f,datadir+"/lhook")
			shutil.move(kinf,datadir+"/lhook")
			shutil.move(accelf,datadir+"/lhook")

		for f in rhook:
			kinf="kin"+str(f[4:])
			accelf="accel"+str(f[4:])
			shutil.move(f,datadir+"/rhook")
			shutil.move(kinf,datadir+"/rhook")
			shutil.move(accelf,datadir+"/rhook")

		for f in luppercut:
			kinf="kin"+str(f[4:])
			accelf="accel"+str(f[4:])
			shutil.move(f,datadir+"/luppercut")
			shutil.move(kinf,datadir+"/luppercut")
			shutil.move(accelf,datadir+"/luppercut")

		for f in ruppercut:
			kinf="kin"+str(f[4:])
			accelf="accel"+str(f[4:])
			shutil.move(f,datadir+"/ruppercut")
			shutil.move(kinf,datadir+"/ruppercut")
			shutil.move(accelf,datadir+"/ruppercut")

		for f in unknown:
			kinf="kin"+str(f[4:])
			accelf="accel"+str(f[4:])
			shutil.move(f,datadir+"/unknown")
			shutil.move(kinf,datadir+"/unknown")
			shutil.move(accelf,datadir+"/unknown")
	
	except IOError as e:
		print "I/O error({0}): {1}".format(e.errno, e.strerror)



if __name__ == '__main__':
	print  "Organising Data Files...."
	dirbuild()
	kin,meta,accel = getfilelist()
	datasort(meta)



