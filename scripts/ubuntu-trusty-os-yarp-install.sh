if [ "$1" != "" ]; then
export MY_CODE_DIR=$1
    echo "The code will be installed in the directory " $MY_CODE_DIR
    mkdir $MY_CODE_DIR
    mkdir $MY_CODE_DIR/bin
    sudo apt-get -y install libace-dev
    sudo apt-get -y install cmake
    sudo apt-get -y install libgsl0-dev 
    sudo apt-get install qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev \
       qtdeclarative5-qtquick2-plugin qtdeclarative5-window-plugin \
       qtdeclarative5-qtmultimedia-plugin qtdeclarative5-controls-plugin \
       qtdeclarative5-dialogs-plugin libqt5svg5

    cd $MY_CODE_DIR
    git clone https://github.com/robotology/yarp.git
    cd yarp
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$MY_CODE_DIR/bin -DINSTALL_WITH_RPATH:STRING=ON -DCREATE_LIB_MATH:STRING=ON -DCREATE_GUIS:STRING=ON -DQt5_DIR:STRING=/usr/local/opt/qt5/lib/cmake/Qt5 -DCMAKE_CXX_FLAGS=-std=c++11
    make
    make install
    cd ..
    cd ..
    git clone https://github.com/robotology/icub-main.git ./icub
    cd icub
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$MY_CODE_DIR/bin -DICUB_INSTALL_WITH_RPATH:STRING=ON
    make
    make install

    echo 'source ~/.bash_profile'                                                  >> ~/.bashrc 
    echo '#YARP'                                                                   >> ~/.bash_profile
    echo "CODE_DIR="$1                                                            >> ~/.bash_profile
    echo 'export PATH=$PATH:$CODE_DIR/bin/bin'                                     >> ~/.bash_profile
    echo 'export YARP_DIR=$CODE_DIR/yarp'                                          >> ~/.bash_profile
    echo 'export YARP_DATA_DIRS=$CODE_DIR/bin/share/yarp:$CODE_DIR/bin/share/yarp' >> ~/.bash_profile
    echo 'source $CODE_DIR/yarp/scripts/yarp_completion'                           >> ~/.bash_profile
    source ~/.bashrc
else
    echo ""
    echo "Use of this script is: ./ubuntu-trusty-yarp-install.sh /path/where/to/install"
    echo "E.g. ./ubuntu-trusty-yarp-install.sh /home/user/Code"
    echo "Contact: iron@liralab.it (Francesco Nori)"
	echo ""
fi
