;; Auto-generated. Do not edit!


(when (boundp 'interfaces::MoveRobotResult)
  (if (not (find-package "INTERFACES"))
    (make-package "INTERFACES"))
  (shadow 'MoveRobotResult (find-package "INTERFACES")))
(unless (find-package "INTERFACES::MOVEROBOTRESULT")
  (make-package "INTERFACES::MOVEROBOTRESULT"))

(in-package "ROS")
;;//! \htmlinclude MoveRobotResult.msg.html


(defclass interfaces::MoveRobotResult
  :super ros::object
  :slots (_state ))

(defmethod interfaces::MoveRobotResult
  (:init
   (&key
    ((:state __state) "")
    )
   (send-super :init)
   (setq _state (string __state))
   self)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; string _state
    4 (length _state)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _state
       (write-long (length _state) s) (princ _state s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _state
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _state (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get interfaces::MoveRobotResult :md5sum-) "af6d3a99f0fbeb66d3248fa4b3e675fb")
(setf (get interfaces::MoveRobotResult :datatype-) "interfaces/MoveRobotResult")
(setf (get interfaces::MoveRobotResult :definition-)
      "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
#result
string state

")



(provide :interfaces/MoveRobotResult "af6d3a99f0fbeb66d3248fa4b3e675fb")

