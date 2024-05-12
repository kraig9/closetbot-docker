FROM ros:iron-perception

# https://docs.ros.org/en/iron/Installation/Alternatives/Ubuntu-Development-Setup.html
RUN locale  # check for UTF-8 && \ 
    sudo apt update && sudo apt install  && \
    sudo locale-gen en_US en_US.UTF-8 && \
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    locale  # verify settings

RUN sudo apt update && sudo apt install -y software-properties-common && \
    sudo add-apt-repository universe

# RUN sudo apt update && sudo apt install curl -y && \
#     sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN sudo apt update && sudo apt install -y \
    python3-flake8-docstrings \
    python3-pip \
    python3-pytest-cov \
    python3-flake8-blind-except \
    python3-flake8-builtins \
    python3-flake8-class-newline \
    python3-flake8-comprehensions \
    python3-flake8-deprecated \
    python3-flake8-import-order \
    python3-flake8-quotes \
    python3-pytest-repeat \
    python3-pytest-rerunfailures \
    ros-dev-tools

# make my workspace and clone my project
WORKDIR /home
RUN git clone https://github.com/kraig9/closetbot.git
WORKDIR /home/closetbot

# fix dependencies before building
RUN apt install -y curl
RUN curl -o upstream.repos https://raw.githubusercontent.com/tylerjw/mycobot/main/upstream.repos
RUN vcs import src < upstream.repos
RUN rosdep install -r -y --from-paths src --ignore-src

# install more stuff
RUN apt-get install -y ros-iron-controller-manager
RUN apt-get install -y ros-iron-moveit
RUN apt-get install -y ros-iron-gazebo-ros-pkgs
RUN apt install -y libpulse-dev pulseaudio  pulseaudio-utils apulse 
RUN apt install -y libasound2-plugins 

# # build
# SHELL ["/bin/bash", "-c"]
# RUN /opt/ros/iron/local_setup.bash 
# RUN colcon build
# RUN install/setup.bash