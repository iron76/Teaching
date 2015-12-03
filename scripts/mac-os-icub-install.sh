if [ "$1" != "" ]; then
export MY_CODE_DIR=$1
    echo "The code will be installed in the directory " $MY_CODE_DIR
    # build installation directories
	mkdir $MY_CODE_DIR

	# brew dependencies 
	brew install sdl sdl_gfx sdl_image gcc
	brew install ode --with-double-precision
	# brew tap homebrew/science
	# brew install opencv
	
    # get iCub code
    cd $MY_CODE_DIR
    git clone https://github.com/robotology/icub-main.git ./icub
    cd icub
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$MY_CODE_DIR/bin -DICUB_INSTALL_WITH_RPATH:STRING=ON 
    make
    make install
	
    echo '#ICUB'                                                                   >> ~/.bash_profile
    echo "CODE_DIR="$1                                                             >> ~/.bash_profile
    echo 'export PATH=$PATH:$CODE_DIR/bin/bin'                                     >> ~/.bash_profile
	echo "Executing bash profile..."
    . ~/.bash_profile
	echo "...script terminated."
else
	echo ""
    echo "Use of this script is: ./mac-os-icub-install.sh /path/where/to/install"
    echo "E.g. ./mac-os-icub-install.sh /home/user/Code"
    echo "Contact: iron@liralab.it (Francesco Nori)"
	echo ""
fi
