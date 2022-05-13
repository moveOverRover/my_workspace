FROM osrf/ros:foxy-ros1-bridge

# Use bash instead of sh
# SHELL ["/bin/bash", "-c"]
# ENV DEBIAN_FRONTEND=noninteractive

# RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
# RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# # update system image and install git
# RUN apt-get update && apt upgrade -y \
#     && apt-get install -y \
#     software-properties-common wget git \
#     && rm -rf /var/lib/apt/lists/*

RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654

# Kinova Kortex Gen 3 arm packages 
RUN apt-get update && apt-get -y install python3-pip
RUN pip install conan
ENV CONAN_REVISIONS_ENABLED=1
RUN apt-get -y install ros-noetic-gazebo-ros
RUN apt-get -y install ros-noetic-gazebo-ros-control
RUN apt-get -y install ros-noetic-robot-state-publisher
RUN apt-get -y install ros-noetic-moveit && apt-get -y install ros-noetic-moveit-kinematics
RUN apt-get -y install ros-noetic-xacro
RUN apt-get -y install  ros-noetic-ros-controllers ros-noetic-ros-control
RUN apt-get -y install ros-noetic-octomap-rviz-plugins
RUN apt-get -y install libzbar0 && pip install pyzbar
RUN pip install imutils
RUN apt-get -y install gstreamer1.0-tools gstreamer1.0-libav libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-base
RUN apt-get -y install ros-noetic-rgbd-launch

# Dynamixel Packages
RUN apt-get -y install python3-colcon-common-extensions
RUN pip install click
RUN apt-get -y install ros-foxy-gazebo-ros-pkgs
RUN apt-get -y install ros-foxy-gazebo-ros2-control
RUN apt-get -y install ros-foxy-xacro
RUN apt-get -y install ros-foxy-ros2-control
RUN apt-get -y install ros-foxy-ros2-controllers 

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get -y update && apt-get -y upgrade

ADD ros_entrypoint.sh /usr/bin/ros_entrypoint
RUN chmod +x /usr/bin/ros_entrypoint

ENTRYPOINT [ "ros_entrypoint" ]