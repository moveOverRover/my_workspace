# my_workspace
xhost +local:docker

docker exec -it my_workspace_ros_devel_workspace_1 bash -c "source /opt/ros/noetic/setup.bash ;
        source /home/alex/dev/irl_kortex/catkin_ws/devel/setup.bash; bash"

docker exec -it my_workspace_ros_devel_workspace_1 bash -c "source /opt/ros/noetic/setup.bash ;
        source /home/alex/dev/irl_kortex/catkin_ws/devel/setup.bash; 
        cd /home/alex/dev/irl_kortex/catkin_ws;
        bash"

docker run ros_devel_workspace -c "source /opt/ros/foxy/setup.bash ;
        source /ros2_ws/install/setup.bash; ls"
