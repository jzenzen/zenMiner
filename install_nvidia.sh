#!/bin/bash

# Author: Johan Zenzén
# Version: 2021-01-18
#
# Donations:
# XMR: 435a664C8oJTcH3mbAXLvUHQs5EJkonwrJ9jgKzfMNLRAaNVPB2AqBMdYj9wCZckPc9yyd153B983F6iaFmfg5QE267XQsC
#
# This describes the simplest way to get a miner up and running without trusting online bootable images.

# Install bare Debian 10 from Debian Live or any other USB bootable Debian.
# No extra packages is needed.


#Nvidia CUDA -------------------------------------------------------------
# Info: https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Debian&target_version=10&target_type=debnetwork
#
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/7fa2af80.pub
add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/ /"
add-apt-repository contrib
add-apt-repository non-free
apt-get update
apt-get -y install cuda

#For NVIDIA overclocking - and re-run nvidia-xconfig every time you change hardware setup ---------------
apt install -y xinit
nvidia-xconfig --cool-bits=31 --allow-empty-initial-configuration -a

