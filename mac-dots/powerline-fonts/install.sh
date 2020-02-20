set -eu

install () {
    if [ -e "${HOME}/Library/Fonts/Source Code Pro for Powerline.otf" ]
    then
        return
    fi

    echo "Installing powerline fonts" >&3

    git clone --depth 1 "https://github.com/powerline/fonts.git"
    cd ./fonts && ./install.sh
    cd ../
    rm ./fonts -rf
}

install
