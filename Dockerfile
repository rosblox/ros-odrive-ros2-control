ARG ROS_DISTRO

FROM ros:${ROS_DISTRO}-ros-core


RUN apt update && apt install -y --no-install-recommends \
    python3-pip \
    python3-colcon-common-extensions \
    build-essential \
    libusb-1.0-0-dev ros-foxy-ros2-control ros-foxy-ros2-controllers ros-foxy-xacro ros-foxy-robot-state-publisher \
    && rm -rf /var/lib/apt/lists/*


RUN pip3 install odrive==0.5.3.post0


WORKDIR /colcon_ws/src
COPY odrive_ros2_control odrive_ros2_control 

WORKDIR /colcon_ws
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --symlink-install

WORKDIR /

COPY ros_entrypoint.sh .

#docker run -it --rm --volume /dev/bus/usb:/dev/bus/usb --privileged --net=host odrive:latest