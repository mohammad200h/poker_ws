#include <gazebo/gazebo.hh>          // for accessing all gazebo classes
#include <gazebo/common/common.hh>   // for common fn in gazebo like ModelPlugin, event, GetName()
#include <gazebo/physics/physics.hh> // for gazebo physics, to access -- ModelPtr
#include <ignition/math/Vector3.hh>  // to access Vector3d() from ignition math class
#include <ignition/math/Color.hh>    // to access Color() from ignition math class
#include "ros/ros.h"
#include "std_msgs/String.h"

namespace gazebo
{
    class LightControlPlugin : public ModelPlugin
    {

    public:
        void Load(physics::ModelPtr _model, sdf::ElementPtr _sdf)
        {
            // Store the pointer to the model
            this->model = _model;

            // initlize tranport node to publish on light msg
            transport::NodePtr node(new transport::Node());
            node->Init();

            // publish light state
            light_pub = node->Advertise<msgs::Light>("~/light/modify");

            sub  = node->Subscribe("~/indicator_light_gazebo_model", &LightControlPlugin::On_msg, this);

            // ##############ROS NODE##################
            if (!ros::isInitialized())
            {
                int argc = 0;
                char **argv = NULL;

                ros::init(argc, argv, "my_ros_node",
                    ros::init_options::NoSigintHandler);
            }

            // Create ROS node.
            this->rosNode.reset(new ros::NodeHandle( "my_ros_node" ));
            ros_sub = this->rosNode->subscribe("/light_control", 1000, &LightControlPlugin::ros_callback, this);

            // ##############ROS NODE::END##################
            

            // Listen to the update event. This event is broadcast every
            // simulation iteration.
            this->updateConnection = event::Events::ConnectWorldUpdateBegin(std::bind(&LightControlPlugin::OnUpdate, this));

            //                                                    bind() is use to bind this & OnUpdate i.e this->OnUpdate
            //                            bind- we don't have define callback fn input parametes its replace by placeholder

            // get model name 
            model_name = model->GetName();

            // c++11 onwoards, "auto" - automatically detects and assigns a data type to the variable

            // method to get light name from sdf in move_light_model.world
            auto Link = this->model->GetSDF()->GetElement("link");
            this->Link_name = Link->Get<std::string>("name");
            this->Link_name ="base_light";
            auto sdfLight = Link->GetElement("light");
            this->light_name = sdfLight->Get<std::string>("name");

            // naming the complete light to publish
            complete_light_name = this->model_name + "::" + this->Link_name + "::" + this->light_name;
            std::cout << "complete_light_name=" << complete_light_name << "\n";
        }
        void control_light(bool activate)
        {

            msgs::Light light_msg;

            light_msg.set_name(this->complete_light_name);

            if (activate)
            {
                // set light color to white
                msgs::Set(light_msg.mutable_diffuse(), ignition::math::Color(0,0.9,0.1,1 ));
                // std::cout << "light on \n";
            }
            else
            {
                // set light color to black
                msgs::Set(light_msg.mutable_diffuse(), ignition::math::Color(0.8,0,0.2 , 1.0));
                // std::cout << "light off \n";
            }
            // Send the message on topic
            light_pub->Publish(light_msg);
        }

        // keep on updating as simulation iterates
    public:
        void OnUpdate()
        {

          

            if (!this->operation) // if count is 10000
            {
                this->control_light(false); // red light
            }
            
            if (this->operation) //if count is 20000
            {
                this->control_light(true); // green light
            }

        }
        void On_msg(auto &_msg)
        {
          
          // Dump the message contents to stdout.
          std::cout << _msg;  //print output in the terminal
          
        }
        void ros_callback(const std_msgs::String::ConstPtr& msg){
             ROS_INFO("I heard: [%s]", msg->data.c_str());
             if (msg->data =="g")
                this->operation = true;
            else
                this->operation = false;

        }
     

        
    private:
        physics::ModelPtr model;  // Pointer to the model

    private:
        bool operation = false;
        std::string model_name, Link_name, light_name;   // model, link & light name
        std::string complete_light_name;     // complete light name to publish 
        std::unique_ptr<ros::NodeHandle> rosNode;
        ros::Publisher rosPub;

    public:
        transport::PublisherPtr light_pub;  // light publisher
        transport::SubscriberPtr sub; 
        ros::Subscriber  ros_sub;

        
    private:
        event::ConnectionPtr updateConnection; // Pointer to the update event connection
    };

    // Register this plugin with the simulator
    GZ_REGISTER_MODEL_PLUGIN(LightControlPlugin)
}