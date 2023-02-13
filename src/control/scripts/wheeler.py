#!/usr/bin/env python

import rospy
import actionlib

from interfaces.msg import MoveRobotAction
from interfaces.msg import MoveRobotResult
from interfaces.msg import MoveRobotFeedback

from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from std_msgs.msg import Float64,String

class Wheeler:
    def __init__(self):
       
        self._as = actionlib.SimpleActionServer('mission_control',MoveRobotAction,execute_cb = self.on_goal,auto_start = False)
        rospy.loginfo("mission_control server is up")

        self.pub_vel = rospy.Publisher('/wheeler/cmd_vel', Twist, queue_size=10)
        self.pub_actuator = rospy.Publisher('/poker/arm_base_position_controller/command', Float64, queue_size=10)
        rospy.Subscriber('/wheeler/odom',Odometry,self.update_robot_state_cb)
      
        self._as.start()

        # state 
        self.odem=None
     


    def on_goal(self,goal):
        rospy.loginfo("on_goal::called")
       
        
        vel = goal.vel
        dep = goal.deployed
        rospy.loginfo("on_goal::vel::"+str(vel))
        rospy.loginfo("on_goal::dep::"+str(dep))

       
        # rate = rospy.Rate(0.01)
        
        success = False
        preempt = False
        old_odm = self.odem

        self.move(vel)
        self.deploy(dep)

        while not rospy.is_shutdown():
            
            if self._as.is_preempt_requested():
                preempt = True
                break
            
            if self.odem==None:
               
                success = True
                break
            elif self.odem.pose != old_odm.pose:
                success = True
                break

            
            rospy.sleep(0.1)



        result = MoveRobotResult()
        result.state = "Current vel is: "+str(vel)
        
        if success:
            rospy.loginfo("Success")
            self._as.set_succeeded(result)
        elif(preempt):
            rospy.loginfo("Preempted")
            self._as.set_preempted(result)
        else:
            rospy.loginfo("Failure")
            self._as.set_aborted(result)

    def move(self,vel):
        msg = Twist()
        linear_x = vel
        angular_z = 0

        msg.linear.x = linear_x
        msg.angular.z = angular_z
        
        self.pub_vel.publish(msg)
    
    def deploy(self,flag):
        msg = Float64()
        if flag:
            msg.data = 0.5
        else:
            msg.data = 0.0
        self.pub_actuator.publish(msg)
        

    def update_robot_state_cb(self,data):
        self.odem=data
        


def main():
    rospy.init_node('wheeler')
    w = Wheeler()
    rospy.spin()
   

if __name__ == '__main__':
    main()  