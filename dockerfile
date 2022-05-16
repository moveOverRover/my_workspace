FROM osrf/ros:foxy-ros1-bridge


RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
RUN apt-get update && apt-get install ros-noetic-genpy

# Kinova Kortex Gen 3 arm packages 
RUN apt-get update && apt-get -y install python3-pip
RUN pip install conan
ENV CONAN_REVISIONS_ENABLED=1
RUN apt-get -y install \
    ros-noetic-gazebo-ros \
    ros-noetic-gazebo-ros-control \ 
    ros-noetic-robot-state-publisher \ 
    ros-noetic-moveit \
    ros-noetic-moveit-kinematics \ 
    ros-noetic-xacro \
    ros-noetic-ros-controllers ros-noetic-ros-control\
    ros-noetic-octomap-rviz-plugins \
    libzbar0 && pip install pyzbar \
    ros-noetic-image-pipeline 
RUN pip install imutils
RUN apt-get -y install gstreamer1.0-tools gstreamer1.0-libav libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-base \
    ros-noetic-rgbd-launch

# Dynamixel Packages
RUN apt-get -y install python3-colcon-common-extensions
RUN pip install click
RUN apt-get -y install \
    ros-foxy-gazebo-ros-pkgs \
    ros-foxy-gazebo-ros2-control \
    ros-foxy-xacro \
    ros-foxy-ros2-control \
    ros-foxy-ros2-controllers

# things I need


ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ADD ros_entrypoint.sh /usr/bin/ros_entrypoint
RUN chmod +x /usr/bin/ros_entrypoint

ENTRYPOINT ["ros_entrypoint"]