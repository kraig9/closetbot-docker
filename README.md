# closetbot-docker


start container with compose
source ros
source /opt/ros/iron/local_setup.bash
colcon build in closetbot dir
source install/setup.bash


## to get rviz and gazebo to show gui on host


https://www.youtube.com/watch?v=qWuudNxFGOQ&t=816s
https://www.youtube.com/watch?v=DW7l9LHdK5c


Dockerfile needs:
    ports:
      - "5901:5901"
    environment:
      - VNC_RESOLUTION=1280x720
      - VNC_PASSWORD=mypassword
      - DISPLAY=host.docker.internal:0.0


need to download vcxsrv
https://sourceforge.net/projects/vcxsrv/

run xlaunch, set -1 option to 0
on next screen, uncheck native opengl, check disable access control


ON DOCKER SIDE:
export LIBGL_ALWAYS_INDIRECT=0
export GAZEBO_IP=127.0.0.1

I don't think you need this one....
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0 

because this makes it work, also in docker compose
DISPLAY=host.docker.internal:0.0

LASTLY COPY THE STL FILES FROM THE DEXARM REPO!!! YOU MIGHT NEED TO SETUP UP A VOLUME MOUNT OR SOME SHIT!!!