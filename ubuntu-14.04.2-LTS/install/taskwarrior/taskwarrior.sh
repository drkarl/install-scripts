#!/bin/bash

sudo apt-get install cmake uuid-dev
cmake .
make
sudo make install
cd ..
rm -rf task.git
