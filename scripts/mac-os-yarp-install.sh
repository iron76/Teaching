if [ "$1" != "" ]; then
export MY_CODE_DIR=$1
    echo "The code will be installed in the directory " $MY_CODE_DIR
    # build installation directories
	mkdir $MY_CODE_DIR

	# first install brew
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew doctor 
	brew update
	brew upgrade

	# install yarp dependecies
	brew tap homebrew/x11
	brew tap homebrew/science
	brew install qt5
	brew linkapps qt5
	brew install bash-completion
	brew install yarp --only-dependencies --with-qt5

    # get YARP code
    cd $MY_CODE_DIR
    git clone https://github.com/robotology/yarp.git
    cd yarp
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$MY_CODE_DIR/bin -DINSTALL_WITH_RPATH:STRING=ON -DCREATE_LIB_MATH:STRING=ON -DCREATE_GUIS:STRING=ON -DQt5_DIR:STRING=/usr/local/opt/qt5/lib/cmake/Qt5 -DCMAKE_CXX_FLAGS=-std=c++11
	make
	make install
	
    echo '#YARP'                                                                   >> ~/.bash_profile
    echo "CODE_DIR="$1                                                             >> ~/.bash_profile
    echo 'export PATH=$PATH:$CODE_DIR/bin/bin'                                     >> ~/.bash_profile
    echo 'export YARP_DIR=$CODE_DIR/yarp'                                          >> ~/.bash_profile
    echo 'export YARP_DATA_DIRS=$CODE_DIR/bin/share/yarp:$CODE_DIR/bin/share/yarp' >> ~/.bash_profile
    echo 'source $CODE_DIR/yarp/scripts/yarp_completion'                           >> ~/.bash_profile
	echo 'source $(brew --prefix)/etc/bash_completion'                             >> ~/.bash_profile
	echo "Executing bash profile..."
    . ~/.bash_profile
	echo "...script terminated."
else
    echo ""
    echo "Use of this script is: ./mac-os-yarp-install.sh /path/where/to/install"
    echo "E.g. ./mac-os-yarp-install.sh /home/user/Code"
    echo "Contact: iron@liralab.it (Francesco Nori)"
	echo ""
fi



