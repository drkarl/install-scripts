#!/bin/bash

sudo apt-get install cmake uuid-dev 
git clone https://git.tasktools.org/scm/tm/task.git ~/task.git
cd ~/task.git
cmake .
make
sudo make install
cd ..
rm -rf task.git
