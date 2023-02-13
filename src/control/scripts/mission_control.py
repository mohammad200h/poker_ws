#!/user/bin/env python

import rospy
import actionlib

from interfaces.msg import MoveRobotAction
from interfaces.msg import MoveRobotGoal

from std_msgs.msg import String

from pynput import keyboard
import time
from threading import Thread


class Keyboard_control():
  def __init__(self):
    
    self.state = {
        "vel_x":0,
        "vel_y":0,
        "deploy":False   
    }
 

    self.dx = 0.01
    self.dz = 0.01
    self.dy = 0.01

    self.dxr = 0.01
    self.dzr = 0.01
    self.dyr = 0.01

  def run(self):
    listener = keyboard.Listener(
    on_press=self.process_keyboard)
   
    listener.start()
    
  def process_keyboard(self,key):
    time.sleep(0.1)

    # print("process_keyboard::key",key)
    if key   ==keyboard.Key.up:
        # print("process_keyboard::up")
        self.state["vel_x"] +=self.dx

    elif key ==keyboard.Key.down:
        self.state["vel_x"] -=self.dx
    elif key==keyboard.Key.space:
        self.state["deploy"] = not self.state["deploy"]

    
      
  def get_state(self):
    return self.state



class MissionControl(Thread):
    def __init__(self):
        Thread.__init__(self)
        self.daemon = False
        self.deploy_flag = False
       
        self._ac = actionlib.SimpleActionClient('/mission_control',MoveRobotAction)
        rospy.Subscriber('/light_control',String,self.update_deploy_state_cb)
        self._ac.wait_for_server()
        rospy.loginfo("MissionControl is up:\n Move robot by up and down arrow \n Deply acutator with space!")
        self.start()
      
    def send_goal_and_get_result(self,vel,deploy):
        rospy.loginfo("sending goal!")
        if self.deploy_flag:
            goal = MoveRobotGoal(vel=vel,deployed=deploy)
        else:
            goal = MoveRobotGoal(vel=vel,deployed=False)
        
        # check if obj is too far before sending gaol

        self._ac.send_goal(goal,done_cb=self.done_callback,feedback_cb=self.feedback_callback)

    def done_callback(self,status,result):
        rospy.loginfo("Status is: "+str(status))
        rospy.loginfo("Reuslt is: "+str(result))
        return 
    
    def feedback_callback(self,feedback):
        rospy.loginfo("Feedback is: "+str(feedback))
        return

    def update_deploy_state_cb(self,data):
        flag_str =data.data
        if flag_str =="g":
            self.deploy_flag = True
        else:
            self.deploy_flag = False




if __name__ =='__main__':
    rospy.init_node("mission_control_node")
    # rate = rospy.Rate(0.01)
    mc = MissionControl()
    
    
    kb = Keyboard_control()
    kb.run()


    
 

    old = {
        "vel_x":0,
        "deploy":None

    }
    while not rospy.is_shutdown():
        print("I am inside")
        kb_state = kb.get_state()
        print("kb_state:: ",kb_state)
        if kb_state["vel_x"]!=old["vel_x"] or kb_state["deploy"]!=old["deploy"]:
            mc.send_goal_and_get_result(kb_state["vel_x"],kb_state["deploy"])
            old["vel_x"] = kb_state["vel_x"]
            old["deploy"] = kb_state["deploy"]
        rospy.sleep(0.1)
            
  
    


   
