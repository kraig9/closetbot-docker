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

I put these in the docker compose, so I don't think they're necessary anymore.
ON DOCKER SIDE (or in docker compose file):

I don't think this first display variable is necessary at all.

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0 


The rest of these are in docker compose file.
export LIBGL_ALWAYS_INDIRECT=0
export GAZEBO_IP=127.0.0.1
DISPLAY=host.docker.internal:0.0

LASTLY COPY THE STL FILES FROM THE DEXARM REPO!!! YOU MIGHT NEED TO SETUP UP A VOLUME MOUNT OR SOMETHING!!!
https://github.com/Rotrics-Dev/URDF-of-DexArm/tree/main/URDF/STL
