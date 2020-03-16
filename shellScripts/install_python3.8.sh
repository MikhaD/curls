#!/bin/bash

version="3.8.2"

clear

# Install the tools required to build python
echo "Installing required source building tools..."
sudo apt-get install build-essential checkinstall > dev/null
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-devzlib1g-dev > dev/null
#Navigate to /opt dir where python will be installed
cd /opt
#Download tar archive
echo "Downloading Python source archive..."
sudo wget https://www.python.org/ftp/python/${version}/Python-${version}.tgz > dev/null
#Extract tar archive
echo "Extracting..."
sudo tar xzf Python-${version}.tgz > dev/null
#Delete tar archive
sudo rm -rf Python-${version}.tgz > dev/null

cd Python-${version}
#Generate make file
echo "Preparing to make source..."
sudo ./configure --enable-optimizations > dev/null
echo "making, this will take a while..."
sudo make install > dev/null
cd ~

echo "Python ${version} edition installation complete"
read -p "Do you want to delete this script [Y/n]: " i
if [ ${i:-y} != n ]
then
  rm -rf `basename "$0"`
fi

echo "Installation courtesy of MikhaD"