FROM maprtech/pacc:6.0.1_5.0.0_ubuntu16_yarn_fuse_streams

# System
RUN sudo apt-get update -y
RUN sudo apt-get install -y vim
RUN sudo apt-get install -y locate

# Python2.7 + Libs
RUN sudo apt-get install -y python2.7 python-pip
RUN sudo pip install --upgrade pip
RUN sudo apt-get install -y python-dev pkg-config
RUN sudo apt-get install -y libavformat-dev
RUN sudo apt-get install -y libavcodec-dev
RUN sudo apt-get install -y libavdevice-dev
RUN sudo apt-get install -y libavutil-dev
RUN sudo apt-get install -y libswscale-dev
RUN sudo apt-get install -y libavresample-dev
RUN sudo apt-get install -y libavfilter-dev
RUN sudo pip install av
RUN sudo pip install requests
RUN sudo apt-get install -y python-opencv
RUN sudo pip install image
RUN sudo pip install pillow
RUN sudo apt-get install -y python-numpy
RUN sudo pip install Flask

# Python lib for Ryze (DJI) Tello drone
RUN sudo pip install tellopy

# MapR-ES setup
RUN export LD_LIBRARY_PATH=/opt/mapr/lib:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server
RUN sudo pip install --global-option=build_ext --global-option="--library-dirs=/opt/mapr/lib" --global-option="--include-dirs=/opt/mapr/include/" mapr-streams-python

# Copy scripts
COPY producer.py /home/mapr/
COPY consumer.py /home/mapr/
