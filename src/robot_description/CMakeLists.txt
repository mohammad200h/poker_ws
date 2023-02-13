cmake_minimum_required(VERSION 3.0.2)
project(robot_description)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++17)

find_package(gazebo REQUIRED)
find_package(catkin REQUIRED COMPONENTS
  gazebo
  gazebo_plugins
  roscpp
  rospy
  gazebo_ros
  std_msgs
)


include_directories(
# include
  ${catkin_INCLUDE_DIRS}
  ${GAZEBO_INCLUDE_DIRS}
)

link_directories(${GAZEBO_LIBRARY_DIRS})
include_directories(${BOOST_INCLUDE_DIR},${catkin_INCLUDE_DIRS},$GAZEBO_INCLUDE_DIRS)
link_directories(${GAZEBO_LIBRARY_DIRS})
list(APPEND CMAKE_CXX_FLAGS "${GAZEBO_CXX_FLAGS}")

catkin_package(
  DEPENDS
  rospy
  gazebo_ros
  gazebo
  gazebo_plugins
)

add_library(light_on_off_plugin SHARED src/light_on_off_plugin.cc)
add_library(light_control_plugin SHARED src/light_control_plugin.cc)


target_link_libraries(light_on_off_plugin ${GAZEBO_LIBRARES})
target_link_libraries(light_control_plugin ${GAZEBO_LIBRARES})







