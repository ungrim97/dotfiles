set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

ANYENV_BASE="${HOME}/.anyenv"

install () {
    if ! is_git_command_available
    then
        echo "Unable to install anyenv... git command not found" >&2
        return ${STATUS_ERROR}
    fi

    install_anyenv  || return ${STATUS_ERROR}
    install_plugins || return ${STATUS_ERROR}
}

install_anyenv () {
    if [ -e "${ANYENV_BASE}" ]
    then
        if [ -e "${ANYENV_BASE}/plugins/anyenv-update" ]
        then
            anyenv update
        fi
        return
    fi

    echo "Installing anyenv"
    git clone --depth 1 https://github.com/riywo/anyenv $ANYENV_BASE
    eval "$(anyenv init - zsh)"
}

install_plugins () {
    if [ ! -e "${ANYENV_BASE}/plugins" ]
    then
        mkdir "${ANYENV_BASE}/plugins"
    fi

    if [ ! -e "${ANYENV_BASE}/plugins/anyenv-update" ]
    then
    	echo "Fetching anyenv-update"
        git clone --depth 1 https://github.com/znz/anyenv-update.git "${ANYENV_BASE}/plugins/anyenv-update"
    fi

    if [ ! -e "${ANYENV_BASE}/plugins/anyenv-git" ]
    then
    	echo "Fetching anyenv-git"
        git clone --depth 1 https://github.com/znz/anyenv-git.git "${ANYENV_BASE}/plugins/anyenv-git"
    fi
}

install
