;; Auto-generated. Do not edit!


(when (boundp 'interfaces::MoveRobotGoal)
  (if (not (find-package "INTERFACES"))
    (make-package "INTERFACES"))
  (shadow 'MoveRobotGoal (find-package "INTERFACES")))
(unless (find-package "INTERFACES::MOVEROBOTGOAL")
  (make-package "INTERFACES::MOVEROBOTGOAL"))

(in-package "ROS")
;;//! \htmlinclude MoveRobotGoal.msg.html


(defclass interfaces::MoveRobotGoal
  :super ros::object
  :slots (_vel _deployed ))

(defmethod interfaces::MoveRobotGoal
  (:init
   (&key
    ((:vel __vel) 0.0)
    ((:deployed __deployed) nil)
    )
   (send-super :init)
   (setq _vel (float __vel))
   (setq _deployed __deployed)
   self)
  (:vel
   (&optional __vel)
   (if __vel (setq _vel __vel)) _vel)
  (:deployed
   (&optional (__deployed :null))
   (if (not (eq __deployed :null)) (setq _deployed __deployed)) _deployed)
  (:serialization-length
   ()
   (+
    ;; float64 _vel
    8
    ;; bool _deployed
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _vel
       (sys::poke _vel (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _deployed
       (if _deployed (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _vel
     (setq _vel (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _deployed
     (setq _deployed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get interfaces::MoveRobotGoal :md5sum-) "2870b9bf84a5843cbf44dc91dc346385")
(setf (get interfaces::MoveRobotGoal :datatype-) "interfaces/MoveRobotGoal")
(setf (get interfaces::MoveRobotGoal :definition-)
      "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
#goal

float64 vel
bool deployed

")



(provide :interfaces/MoveRobotGoal "2870b9bf84a5843cbf44dc91dc346385")

