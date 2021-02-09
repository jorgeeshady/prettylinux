#!/bin/bash
#3
#beautylinux v1.0, Author @sh4dy94 (Jorge Delgado)

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c(){

	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Exiting...${endColour}"; sleep 1
    tput cnorm; exit 1
}


function banner(){

	echo -e "\n${greenColour}[PRETTYLINUX]${endColour}"
    echo -e "\n\t${grayColour}Version ${endColour}${redColour}v1.0${endColour}"
    echo -e "\n\t${grayColour}Author ${endColour}${redColour}sh4dy94${endColour}"
    echo -e "\n\t${grayColour}Inspired by s4vitar: ${endColour}${redColour}https://youtu.be/66IAhBI0bCM${endColour}"
    sleep 5
    echo -e "\n\t${blueColour}Starting Instalation....\n${endColour}"

};banner


    echo -e "\n${greenColour}Select version Operation System\n${endColour}"
    echo -e "\t${grayColour}1) Arch Linux\n${endColour}"
    echo -e "\t${grayColour}2) Debian/Ubuntu\n${endColour}"

read var1

#Creation folders and instalation dependencies

function dependencies(){
	sleep 2

	if [ "$(echo $var1)" == "1" ]; then
    	echo -ne "\n${blueColour}Installing PACMAN dependencies...\n\n${endColour}"
        sudo pacman -S libxcb xcb-util xcb-util-wm xcb-util-keysyms
        mkdir -p ~/.config/{bspwm,sxhkd,bin,compton,polybar}

    elif [ "$(echo $var1)" == "2" ]; then
    	echo -ne "\n${blueColour}Instaling  UBUNTU\DEBIAN dependencies\n\n${endColour}"
        sudo apt-get update && sudo apt-get install libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev -y
        mkdir -p ~/.config/{bspwm,sxhkd,bin,compton,polybar}
    else
        echo -ne "\n${redColor}Invalid option, you must to select one of the following options:${endColour}" 
        echo -ne "t\${grayColour}1)PACMAN\n${endColour}"
        echo -ne "t\${grayColour}2)UBUNTU\DEBIAN\n${endColour}"
        exit 1

    fi
}; dependencies


#Install software from repository
function software_repo(){

	echo -ne "\n${blueColour}Installing the following software:\n${endColour}"
	echo -ne "\n\t${greyColour}-scrub${endColour}"
	echo -ne "\n\t${greyColour}-feh${endColour}"
	echo -ne "\n\t${greyColour}-compton${endColour}"
	echo -ne "\n\t${greyColour}-zsh${endColour}"
	echo -ne "\n\t${greyColour}-xclip${endColour}"
	echo -ne "\n\t${greyColour}-dunst${endColour}"
	echo -ne "\n\t${greyColour}-rofi${endColour}"
	echo -ne "\n\t${greyColour}-nautilus${endColour}"
	echo -ne "\n\t${greyColour}-flameshot${endColour}"
	echo -ne "\n\t${greyColour}-gnome-terminal${endColour}"
	sleep 8
	sudo apt-get update && sudo apt-get install scrub feh compton zsh xclip dunst rofi nautilus flameshot gnome-terminal -y

}; software_repo


#Instalation bspwm and sxhkd
function bspwmysxhkd(){
	cd
    echo -ne "\n${greenColour}Clonning and compiling repositores...\n\n${endColour}"
    sleep 5
    git clone https://github.com/baskerville/bspwm.git
    git clone https://github.com/baskerville/sxhkd.git
    cd bspwm && make && sudo make install
    cd ../sxhkd && make && sudo make install
    cd ..

    mkdir ~/.config/bspwm/scripts
    cd ~/.config/bspwm/
	wget "https://raw.githubusercontent.com/sh4dy94/prettylinux/main/bspwm/bspwmrc"
    chmod u+x ~/.config/bspwm/bspwmrc
    cd ../sxhkd
	wget "https://raw.githubusercontent.com/sh4dy94/prettylinux/main/sxhkd/sxhkdrc"
    wget "https://raw.githubusercontent.com/sh4dy94/prettylinux/main/bspwm/scripts/bspwm_resize"
    mv bspwm_resize ~/.config/bspwm/scripts/
    chmod +x ~/.config/bspwm/scripts/bspwm_resize
    cd
    touch ~/.xinitrc
    echo "sxhkd &\nexec bspwm" > ~/.xinitrc

}; bspwmysxhkd


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
	echo -ne "\n\n${greenColour}Building Polybar...\n\n${endColor}"
	sleep 6
    mkdir build && cd build
    cmake .. && make -j$(nproc)
    sudo make install

    cd
    git clone --recursive https://github.com/sh4dy94/prettylinux.git
    cp -rf $HOME/prettylinux/polybar/* $HOME/.config/polybar/
	mkdir -p $HOME/.local/share/fonts
	cp -rf $HOME/prettylinux/polybar/fonts/* $HOME/.local/share/fonts/

}; poly



#Apply configurations like font terminal, rofi theme
function configs(){

	echo -ne "\n${redColour}Copy polybar scripts and apply fonts:\n${endColour}"
	cp -rf $HOME/prettylinux/bin/* $HOME/.config/bin
	chmod +x $HOME/.config/bin/*
    cd $HOME
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
    sudo unzip Hack.zip -d /usr/share/local/fonts/
    sudo fc-cache -v -f
    mkdir -p $HOME/Imágenes/fondos/
    cd $HOME/Imágenes/fondos/
    wget "https://wallpapercave.com/wp/wp1810627.jpg"
    mv wp1810627.jpg mrrobot.jpg
    chmod +x $HOME/.config/polybar/launch.sh
    $HOME/.config/polybar/launch.sh --cuts
    cp -rf $HOME/prettylinux/compton/compton.conf $HOME/.config/compton/
}; configs

kill -9 -1

