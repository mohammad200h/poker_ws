;; Auto-generated. Do not edit!


(when (boundp 'interfaces::MoveRobotAction)
  (if (not (find-package "INTERFACES"))
    (make-package "INTERFACES"))
  (shadow 'MoveRobotAction (find-package "INTERFACES")))
(unless (find-package "INTERFACES::MOVEROBOTACTION")
  (make-package "INTERFACES::MOVEROBOTACTION"))

(in-package "ROS")
;;//! \htmlinclude MoveRobotAction.msg.html


(defclass interfaces::MoveRobotAction
  :super ros::object
  :slots (_action_goal _action_result _action_feedback ))

(defmethod interfaces::MoveRobotAction
  (:init
   (&key
    ((:action_goal __action_goal) (instance interfaces::MoveRobotActionGoal :init))
    ((:action_result __action_result) (instance interfaces::MoveRobotActionResult :init))
    ((:action_feedback __action_feedback) (instance interfaces::MoveRobotActionFeedback :init))
    )
   (send-super :init)
   (setq _action_goal __action_goal)
   (setq _action_result __action_result)
   (setq _action_feedback __action_feedback)
   self)
  (:action_goal
   (&rest __action_goal)
   (if (keywordp (car __action_goal))
       (send* _action_goal __action_goal)
     (progn
       (if __action_goal (setq _action_goal (car __action_goal)))
       _action_goal)))
  (:action_result
   (&rest __action_result)
   (if (keywordp (car __action_result))
       (send* _action_result __action_result)
     (progn
       (if __action_result (setq _action_result (car __action_result)))
       _action_result)))
  (:action_feedback
   (&rest __action_feedback)
   (if (keywordp (car __action_feedback))
       (send* _action_feedback __action_feedback)
     (progn
       (if __action_feedback (setq _action_feedback (car __action_feedback)))
       _action_feedback)))
  (:serialization-length
   ()
   (+
    ;; interfaces/MoveRobotActionGoal _action_goal
    (send _action_goal :serialization-length)
    ;; interfaces/MoveRobotActionResult _action_result
    (send _action_result :serialization-length)
    ;; interfaces/MoveRobotActionFeedback _action_feedback
    (send _action_feedback :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; interfaces/MoveRobotActionGoal _action_goal
       (send _action_goal :serialize s)
     ;; interfaces/MoveRobotActionResult _action_result
       (send _action_result :serialize s)
     ;; interfaces/MoveRobotActionFeedback _action_feedback
       (send _action_feedback :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; interfaces/MoveRobotActionGoal _action_goal
     (send _action_goal :deserialize buf ptr-) (incf ptr- (send _action_goal :serialization-length))
   ;; interfaces/MoveRobotActionResult _action_result
     (send _action_result :deserialize buf ptr-) (incf ptr- (send _action_result :serialization-length))
   ;; interfaces/MoveRobotActionFeedback _action_feedback
     (send _action_feedback :deserialize buf ptr-) (incf ptr- (send _action_feedback :serialization-length))
   ;;
   self)
  )

(setf (get interfaces::MoveRobotAction :md5sum-) "2e0cbb948d05fd8840e6d52b1495628d")
(setf (get interfaces::MoveRobotAction :datatype-) "interfaces/MoveRobotAction")
(setf (get interfaces::MoveRobotAction :definition-)
      "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======

MoveRobotActionGoal action_goal
MoveRobotActionResult action_result
MoveRobotActionFeedback action_feedback

================================================================================
MSG: interfaces/MoveRobotActionGoal
# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======

Header header
actionlib_msgs/GoalID goal_id
MoveRobotGoal goal

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: actionlib_msgs/GoalID
# The stamp should store the time at which this goal was requested.
# It is used by an action server when it tries to preempt all
# goals that were requested before a certain time
time stamp

# The id provides a way to associate feedback and
# result message with specific goal requests. The id
# specified must be unique.
string id


================================================================================
MSG: interfaces/MoveRobotGoal
# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
#goal

float64 vel
bool deployed

================================================================================
MSG: interfaces/MoveRobotActionResult
# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======

Header header
actionlib_msgs/GoalStatus status
MoveRobotResult result

================================================================================
MSG: actionlib_msgs/GoalStatus
GoalID goal_id
uint8 status
uint8 PENDING         = 0   # The goal has yet to be processed by the action server
uint8 ACTIVE          = 1   # The goal is currently being processed by the action server
uint8 PREEMPTED       = 2   # The goal received a cancel request after it started executing
                            #   and has since completed its execution (Terminal State)
uint8 SUCCEEDED       = 3   # The goal was achieved successfully by the action server (Terminal State)
uint8 ABORTED         = 4   # The goal was aborted during execution by the action server due
                            #    to some failure (Terminal State)
uint8 REJECTED        = 5   # The goal was rejected by the action server without being processed,
                            #    because the goal was unattainable or invalid (Terminal State)
uint8 PREEMPTING      = 6   # The goal received a cancel request after it started executing
                            #    and has not yet completed execution
uint8 RECALLING       = 7   # The goal received a cancel request before it started executing,
                            #    but the action server has not yet confirmed that the goal is canceled
uint8 RECALLED        = 8   # The goal received a cancel request before it started executing
                            #    and was successfully cancelled (Terminal State)
uint8 LOST            = 9   # An action client can determine that a goal is LOST. This should not be
                            #    sent over the wire by an action server

#Allow for the user to associate a string with GoalStatus for debugging
string text


================================================================================
MSG: interfaces/MoveRobotResult
# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
#result
string state

================================================================================
MSG: interfaces/MoveRobotActionFeedback
# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======

Header header
actionlib_msgs/GoalStatus status
MoveRobotFeedback feedback

================================================================================
MSG: interfaces/MoveRobotFeedback
# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
#feedback
float64 percentage


")



(provide :interfaces/MoveRobotAction "2e0cbb948d05fd8840e6d52b1495628d")

