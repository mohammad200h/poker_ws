
#!/usr/bin/env python3
import cv2
import sys
import numpy as np 

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
from std_msgs.msg import String



class Viewer:
    def __init__(self):
        self.thresh= 0.45
        self.bridge = CvBridge()

        rospy.Subscriber("/poker/camera1/image_raw", Image, self.callback)
        self.pub_light_indicator = rospy.Publisher('/light_control', String, queue_size=10)
       
    
        
    
       

    def callback(self,data):
  
        processed_img = self.process_data(data)
        obj_image = self.mask_operation(processed_img)

        percentage = self.get_percentage_of_a_specific_color(obj_image)
        msg = String()
        if percentage > self.thresh:
          msg.data  ="g"  
        else:
          msg.data  ="r"

        self.pub_light_indicator.publish(msg)

        cv2.imshow("Image window", processed_img)
        cv2.imshow("Object Window", obj_image)
        cv2.waitKey(3)
      
    # utility functions 
    def process_data(self,data):

        try:
            cv_image = self.bridge.imgmsg_to_cv2(data, "bgr8")
            return cv_image
        except CvBridgeError as e:
            print(e)

    def mask_operation(self,image):

      hsv_frame=cv2.cvtColor(image,cv2.COLOR_BGR2HSV)
      # Blue color 
      low_blue  = np.array([94,80,2])
      high_blue = np.array([126,255,255])
      blue_mask = cv2.inRange(hsv_frame,low_blue,high_blue)
      blue = cv2.bitwise_and(image,image,mask=blue_mask)

      return blue

    def get_percentage_of_a_specific_color(self,segmented_image):
      # print("segmented_image::shape:: ",segmented_image.shape)
      reduced_to_2d = np.sum(segmented_image,axis=2)
      # print(print("reduced_to_2d::shape:: ",reduced_to_2d.shape))
      # print(print("reduced_to_2d:: ",reduced_to_2d))
      flat = reduced_to_2d.flatten()
      num_all_pixels = flat.shape[0]
      # print(print("flat::shape ",flat.shape))
    
      idx_of_none_zero_elements = np.where(flat>0)[0].tolist()
      num_colored_pixels = len(idx_of_none_zero_elements)
      percentage = num_colored_pixels/num_all_pixels
      print("percentage:: ",percentage)
      # print("idx_of_none_zero_elements::len:: ",len(idx_of_none_zero_elements))
      return percentage




def main(args):
  v= Viewer()
  rospy.init_node('viewer', anonymous=True)
  try:
    rospy.spin()
  except KeyboardInterrupt:
    print("Shutting down")
  cv2.destroyAllWindows()

if __name__ == '__main__':
    main(sys.argv)


    


