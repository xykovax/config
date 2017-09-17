#/bin/sh
set -e # exit on first error

install_headers()
{
	sudo apt-get update
	sudo apt-get install -y linux-source linux-headers-$(uname -r) \
		linux-generic
	sudo apt-get update
	sudo apt-get install -y build-essential dkms
}

install_nvidia()
{
    mkdir Downloads
    cd Downloads
    wget http://us.download.nvidia.com/XFree86/Linux-x86_64/352.99/NVIDIA-Linux-x86_64-352.99.run
    chmod 777 NVIDIA-Linux-x86_64-352.99.run
    sudo ./NVIDIA-Linux-x86_64-352.99.run
}
# reboot here
install_cuda()
{
    cd Downloads
    wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_8.0.61-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1404_8.0.61-1_amd64.deb
    sudo apt-get update
    sudo apt-get -y install cuda
}

download_cudnn()
{
    cd Downloads
    # DO IT MANUALLY
    tar -xvf *.tgz
    mv cuda ~
    cd cuda/lib64
    export LD_LIBRARY_PATH=`pwd`:$LD_LIBRARY_PATH
}
##
prepare_python()
{
    sudo apt-get install -y git \
	    python-pip \
	    python-dev \
	    python-matplotlib \
	    libcupti-dev
	sudo pip install pbr
    sudo pip install funcsigs
    sudo pip  install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.0.1-cp27-none-linux_x86_64.whl
}

init()
{
    install_headers
    install_nvidia
#    sudo reboot
    install_cuda

    prepare_python
}

#MAIN
init
