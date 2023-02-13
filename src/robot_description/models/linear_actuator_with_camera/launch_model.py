#!/usr/bin/env python

import pybullet as p




if __name__ == '__main__':
	p.connect(p.GUI)
	objects = p.loadSDF("./model.sdf")
	# ws = p.loadSDF("./meshes/ws/TH/model.sdf")
	while(1):
		

		p.setRealTimeSimulation(1)
