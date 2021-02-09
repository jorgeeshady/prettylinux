function poly(){

	echo -ne "\n${blueColour}Downloading and installing Polybar\n\n${endColour}"
    sleep 5
    sudo apt install -y build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev
    sudo apt install -y libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev

    echo -ne "\n\n${blueColour}Downloading Polybar...\n\n${endColour}"
    sleep 5
    wget "https://github.com/polybar/polybar/releases/download/3.5.4/polybar-3.5.4.tar.gz"
    tar -xf polybar-3.5.4.tar.gz
    sudo rm -r polybar-3.5.4.tar.gz
    sudo mv polybar-3.5.4 polybar
    sudo mv polybar /opt/
    cd /opt/polybar
    echo -ne "\n\n${blueColour}Building Polybar...\n\n${endColour}"
    sleep 6
    mkdir build && cd build
    cmake .. && make -j$(nproc)
    sudo make install

	echo -ne "\n\n${blueColour}Copy files Polybar...\n\n${endColour}"
    cd
    git clone --recursive https://github.com/sh4dy94/prettylinux.git
    cp -rf $HOME/prettylinux/polybar $HOME/.config/polybar/
    mkdir -p $HOME/.local/share/fonts
    cp -rf $HOME/prettylinux/polybar/fonts/ $HOME/.local/share/fonts/

}; poly
