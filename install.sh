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


#Generic -----------------------------------------------------------------
#apt update
#apt upgrade
#apt -y install openssh-server vim git screen

apt install -y software-properties-common dirmngr apt-transport-https lsb-release ca-certificates


#Nvidia CUDA -------------------------------------------------------------
# Info: https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Debian&target_version=10&target_type=debnetwork
#
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/7fa2af80.pub
add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/debian10/x86_64/ /"
add-apt-repository contrib
add-apt-repository non-free
apt-get update
apt-get -y install cuda

#AMD OpenCL --------------------------------------------------------------
# Get Driver from here: https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-40
# Get Patch from here: https://wiki.debian.org/AMDGPUDriverOnStretchAndBuster2?action=AttachFile&do=view&target=01-amdgpu_20.40_on_linux_4.19-v3.patch
# General info: https://wiki.debian.org/AMDGPUDriverOnStretchAndBuster2
wget --referer=https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-40 https://drivers.amd.com/drivers/linux/amdgpu-pro-20.40-1147287-ubuntu-18.04.tar.xz
wget "https://wiki.debian.org/AMDGPUDriverOnStretchAndBuster2?action=AttachFile&do=get&target=01-amdgpu_20.40_on_linux_4.19-v3.patch" -O 01-amdgpu_20.40_on_linux_4.19-v3.patch
tar -xvf ~johan/amdgpu-pro-20.40-1147287-ubuntu-18.04.tar.xz
cd amdgpu-pro-20.40-1147287-ubuntu-18.04/
# Next command will return an error (will be patched below)
./amdgpu-pro-install -y --opencl=pal,legacy,rocm --headless
cd /usr/src/amdgpu-5.6.14.224-1147287/
patch -p1 < ~/01-amdgpu_20.40_on_linux_4.19-v3.patch
cd -
apt install -y opencl-headers clinfo
ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1.0.0 /usr/lib/libOpenCL.so
cd ..

#Reboot
#reboot

#For NVIDIA overclocking - and re-run nvidia-xconfig every time you change hardware setup ---------------
apt install -y xinit
nvidia-xconfig --cool-bits=31 --allow-empty-initial-configuration -a

# AMD overclocking --------------------------------------------------
# git clone https://github.com/matszpk/amdcovc.git
apt-get install -y libpci-dev libncurses5-dev
cd amdcovc
make
cd ..

#Check opencl
clinfo

#Fix vim -------------------------
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

#Fix performance
echo 'vm.nr_hugepages=128' >> /etc/sysctl.conf
sysctl -p

# Monitor AMD Ryzen temp in Linux --------------------------------------------------------------------------
# git clone https://github.com/cyring/CoreFreq.git
cd CoreFreq
make
#insmod corefreqk.ko
#./corefreqd &
#./corefreq-cli
cd ..

#Install XMRig-MoneroOcean
# git clone https://github.com/MoneroOcean/xmrig.git
apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
mkdir xmrig/build && cd xmrig/build
cmake ..
make -j$(nproc)
cd ../../

# CUDA for XMRig-MoneroOcean
# git clone https://github.com/MoneroOcean/xmrig-cuda.git
apt install cuda-toolkit-11.2
mkdir xmrig-cuda/build && cd xmrig-cuda/build
cmake ..
make -j$(nproc)
cp libxmrig-cuda.so ~/xmrig/build/.
cd ../../

#Simple config.json
echo "{\
    \"autosave\": true,\
    \"cpu\": false,\
    \"opencl\": {\
        \"enabled\": false,\
        \"cache\": true,\
        \"loader\": null,\
        \"platform\": \"AMD\",\
        \"adl\": true,\
        \"cn/0\": false,\
        \"cn-lite/0\": false,\
        \"panthera\": false\
    },\
    \"cuda\": true,\
    \"pools\": [\
        {\
            \"coin\": null,\
            \"algo\": null,\
            \"url\": \"gulf.moneroocean.stream:10128\",\
            \"user\": \"435a664C8oJTcH3mbAXLvUHQs5EJkonwrJ9jgKzfMNLRAaNVPB2AqBMdYj9wCZckPc9yyd153B983F6iaFmfg5QE267XQsC\",\
            \"pass\": \"ZenMiner\",\
            \"tls\": false,\
            \"keepalive\": true,\
            \"nicehash\": false\
        }\
    ]\
}\
" > xmrig/build/config.json

#Install Xmr-Stak-RX -------------------------------------------------------------
# git clone https://github.com/fireice-uk/xmr-stak.git -b xmr-stak-rx xmr-stak-rx
apt install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev
mkdir xmr-stak-rx/build
cd xmr-stak-rx/build
cmake ..
make install
cd ../../

#Install Xmr-Stak
#git clone https://github.com/fireice-uk/xmr-stak.git
mkdir xmr-stak/build
cd xmr-stak/build
cmake ..
make install
cd ../../
  ########## You might have to remove compute_30 from CMakeFile


#Install Team Red Miner ------------------------------------------------------------------------
wget https://github.com/todxx/teamredminer/releases/download/0.8.0/teamredminer-v0.8.0-linux.tgz
tar xzf teamredminer-v0.8.0-linux.tgz
rm teamredminer-v0.8.0-linux.tgz

#Install Meta Miner ----------------------------------------------------
#git clone https://github.com/MoneroOcean/meta-miner.git
apt-get install -y nodejs
#-----Needs more----

# Gminer -------------------------------------
wget https://github.com/develsoftware/GMinerRelease/releases/download/2.42/gminer_2_42_linux64.tar.xz
mkdir gminer
(cd gminer && tar xf ../gminer_2_42_linux64.tar.xz)
wget https://github.com/develsoftware/GMinerRelease/releases/download/2.39/gminer_2_39_linux64.tar.xz
mkdir gminer39
(cd gminer39 && tar xf ../gminer_2_39_linux64.tar.xz)
rm gminer*.xz


#T-Rex Miner -------------------------------------------------------------------
wget https://github.com/trexminer/T-Rex/releases/download/0.19.9/t-rex-0.19.9-linux-cuda11.1.tar.gz


#Meta miner -------------------------------------------
apt install -y nodejs


# AUTOSTART -----------------------
#Edit /root/startMining.sh
echo "@reboot /root/startMining.sh" |crontab -

#Rename ethernet device since it might change if we move a graphics or add a graphics card --------------------
sed -e s/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
sed -e "s/auto ens.*/auto eth0/g" /etc/network/interfaces
sed -e "s/iface ens.* inet/iface eth0 inet/g" /etc/network/interfaces
reboot


eth-eu1.nanopool.org:9999 -u 0xfEB86A54ff7896b49342cC4fA73Ef49a57cB0cfc.Zenminer
