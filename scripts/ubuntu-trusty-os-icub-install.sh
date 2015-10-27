if [ "$1" != "" ]; then
export MY_CODE_DIR=$1
    echo "The code will be installed in the directory " $MY_CODE_DIR
    mkdir $MY_CODE_DIR

    # install dependencies
    sudo sh -c 'echo "deb http://www.icub.org/ubuntu trusty contrib/science" > /etc/apt/sources.list.d/icub.list'
    sudo apt-get -y --force-yes install icub-common
    sudo apt-get install libglut3 libglut3-dev
    
    cd $MY_CODE_DIR
    git clone https://github.com/robotology/icub-main.git ./icub
    cd icub
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$MY_CODE_DIR/bin -DICUB_INSTALL_WITH_RPATH:STRING=ON
    make
    make install

    echo 'source ~/.bash_profile'                                                  >> ~/.bashrc 
    echo '#ICUB'                                                                   >> ~/.bash_profile
    echo "CODE_DIR="$1                                                            >> ~/.bash_profile
    echo 'export PATH=$PATH:$CODE_DIR/bin/bin'                                     >> ~/.bash_profile
    echo "Executing bashrc..."
    source ~/.bashrc
    echo "...script terminated."
else
    echo ""
    echo "Use of this script is: ./ubuntu-trusty-icub-install.sh /path/where/to/install"
    echo "E.g. ./ubuntu-trusty-icub-install.sh /home/user/Code"
    echo "Contact: iron@liralab.it (Francesco Nori)"
    echo ""
fi
