// Generated by gencpp from file interfaces/MoveRobotGoal.msg
// DO NOT EDIT!


#ifndef INTERFACES_MESSAGE_MOVEROBOTGOAL_H
#define INTERFACES_MESSAGE_MOVEROBOTGOAL_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace interfaces
{
template <class ContainerAllocator>
struct MoveRobotGoal_
{
  typedef MoveRobotGoal_<ContainerAllocator> Type;

  MoveRobotGoal_()
    : vel(0.0)
    , deployed(false)  {
    }
  MoveRobotGoal_(const ContainerAllocator& _alloc)
    : vel(0.0)
    , deployed(false)  {
  (void)_alloc;
    }



   typedef double _vel_type;
  _vel_type vel;

   typedef uint8_t _deployed_type;
  _deployed_type deployed;





  typedef boost::shared_ptr< ::interfaces::MoveRobotGoal_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::interfaces::MoveRobotGoal_<ContainerAllocator> const> ConstPtr;

}; // struct MoveRobotGoal_

typedef ::interfaces::MoveRobotGoal_<std::allocator<void> > MoveRobotGoal;

typedef boost::shared_ptr< ::interfaces::MoveRobotGoal > MoveRobotGoalPtr;
typedef boost::shared_ptr< ::interfaces::MoveRobotGoal const> MoveRobotGoalConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::interfaces::MoveRobotGoal_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::interfaces::MoveRobotGoal_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::interfaces::MoveRobotGoal_<ContainerAllocator1> & lhs, const ::interfaces::MoveRobotGoal_<ContainerAllocator2> & rhs)
{
  return lhs.vel == rhs.vel &&
    lhs.deployed == rhs.deployed;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::interfaces::MoveRobotGoal_<ContainerAllocator1> & lhs, const ::interfaces::MoveRobotGoal_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace interfaces

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::interfaces::MoveRobotGoal_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::interfaces::MoveRobotGoal_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::interfaces::MoveRobotGoal_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::interfaces::MoveRobotGoal_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::interfaces::MoveRobotGoal_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::interfaces::MoveRobotGoal_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::interfaces::MoveRobotGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "2870b9bf84a5843cbf44dc91dc346385";
  }

  static const char* value(const ::interfaces::MoveRobotGoal_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x2870b9bf84a5843cULL;
  static const uint64_t static_value2 = 0xbf44dc91dc346385ULL;
};

template<class ContainerAllocator>
struct DataType< ::interfaces::MoveRobotGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "interfaces/MoveRobotGoal";
  }

  static const char* value(const ::interfaces::MoveRobotGoal_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::interfaces::MoveRobotGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n"
"#goal\n"
"\n"
"float64 vel\n"
"bool deployed\n"
;
  }

  static const char* value(const ::interfaces::MoveRobotGoal_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::interfaces::MoveRobotGoal_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.vel);
      stream.next(m.deployed);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct MoveRobotGoal_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::interfaces::MoveRobotGoal_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::interfaces::MoveRobotGoal_<ContainerAllocator>& v)
  {
    s << indent << "vel: ";
    Printer<double>::stream(s, indent + "  ", v.vel);
    s << indent << "deployed: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.deployed);
  }
};

} // namespace message_operations
} // namespace ros

#endif // INTERFACES_MESSAGE_MOVEROBOTGOAL_H