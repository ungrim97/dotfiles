set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! is_git_command_available
    then
        echo "Unable to install zsh... git command not found" >&2
        return ${STATUS_ERROR}
    fi

    install_zsh       || return ${STATUS_ERROR}
    install_antigen   || return ${STATUS_ERROR}
    install_noti      || return ${STATUS_ERROR}
    install_oh_my_zsh || return ${STATUS_ERROR}
    install_theme
}

install_zsh () {
    if [ -e /bin/zsh ]
    then
        return
    fi

    brew install zsh
    echo /usr/local/bin/zsh | sudo tee -a /etc/shells > /dev/null
    chsh -s /usr/local/bin/zsh
}

install_antigen () {
    local antigen_script_file="${HOME}/antigen.zsh"

    if [ -e "${antigen_script_file}" ]
    then
        return
    fi

    get_url_to_file "https://git.io/antigen" "${antigen_script_file}" || return 1
}

install_oh_my_zsh () {
    if [ -f ~/.oh-my-zsh ]
    then
        return
    fi

    if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
        mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh
    fi

    get_url_to_file "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh" - | zsh 2>&1

    if [ -f ~/.zshrc.pre-oh-my-zsh ] || [ -h ~/.zshrc.pre-oh-my-zsh ]; then
        mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
    fi
}

install_noti () {
    local noti_binary="${LOCAL_BIN_FOLDER}/noti"
    local noti_download="/tmp/noti.tar.gz"

    if [ -e "${noti_binary}" ]
    then
        return
    fi

    make_local_bin || return ${STATUS_ERROR}

    get_url_to_file "https://github.com/variadico/noti/releases/download/3.0.0/noti3.0.0.darwin-amd64.tar.gz" "${noti_download}" || return 1
    (
        cd "${LOCAL_BIN_FOLDER}"
        tar -xzf "${noti_download}"

        rm "${noti_download}"
    )
}

install_theme () {
    if [ -e "${HOME}/.oh-my-zsh/themes/powerlevel10k" ]
    then
        return
    fi

    git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k
}

install
