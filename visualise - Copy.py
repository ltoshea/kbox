##!/usr/bin/python
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
import numpy as np
from sklearn import decomposition
import csv





def fread(f=None):
	"""Reads in test and training CSVs. (note:training has label in col1)"""
	X = []
	Y = []
	Z = []

	if (f==None):
		print("No file given to read, exiting...")
		sys.exit(1)

	read = csv.reader(open(f,'r'),delimiter = ' ')
	for line in read:
		line = line[:-1]
		X.extend(line[2::4])
		Y.extend(line[3::4])
		Z.extend(line[4::4])
	X = [float(x) for x in X]
	Y = [float(x) for x in X]
	Z = [float(x) for x in X]
	print len(X)
	#
	#print X
	#Y = Y[0::500]
	#Z = Z[0::500]
	#f = open("test.txt", "w")
	#for e in X:
	#	f.write(str(e))
	#	f.write(' ')
	#	f.write('\n')
	#f.close
	return(X,Y,Z)

	

def setup_scatter(X,Y,Z,A,B,C):
	print("ballbags")
	fig = plt.figure()
	ax = fig.add_subplot(111, projection='3d')	
	ax.set_xlabel('X Label')
	ax.set_ylabel('Y Label')
	ax.set_zlabel('Z Label')

	Xsplit = X[0:20]
	Ysplit = X[0:20]
	Zsplit = X[0:20]
	ax.set_autoscale_on(False)
	v = [-1,0,-1.1,2]
	ax.axis(v)
	ax.set_zlim3d(-1.1, 2)


	#ax.plot(Xsplit,Ysplit,Zsplit, zdir='z', s=10, c='r')
	ax.scatter(Xsplit,Ysplit,Zsplit, zdir='z', s=10, c='r')
	#ax.scatter(A,B,C, zdir='z', s=10, c='y')
	plt.show()
	#print X
	#print Y
	#ax.scatter(X, Y, marker='^', c='r')
	
	
	#plt.xlim((-2,0))
	#plt.plot(X,Y)
	

#	Axes3D.scatter(X, Y, zs=0, zdir='z', s=20, c='b', *args, **kwargs)


if __name__ == '__main__':
	print("Hello")
	X,Y,Z = fread("kin_2014-03-11_20-45-59.txt")
	A,B,C = fread("kin_2014-03-11_20-47-27.txt")
	setup_scatter(X,Y,Z,A,B,C)

	
	
	