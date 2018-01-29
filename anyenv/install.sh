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
    install_plenv   || return ${STATUS_ERROR}
    install_ndenv   || return ${STATUS_ERROR}
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

install_plenv () {
    # Don't install if already installed
    if [ -e "${ANYENV_BASE}/envs/plenv" ]
    then
        return
    fi

    echo "Installing PLENV"

    # Don't install if perlbrew is in use
    if [ -e "${HOME}/.perlbrew" ]
    then
	echo "Can't install plenv when perlbrew is in use"
        return
    fi

    anyenv install plenv
    eval "$(plenv init - zsh)"

    # Use latest
    plenv install 5.24.0 -Dusethreads
    plenv global 5.24.0

    # CPANM
    plenv install-cpanm
    plenv rehash
}

install_ndenv () {
    # Don't install if already installed
    if [ -e "${ANYENV_BASE}/envs/ndenv" ]
    then
        return
    fi

    echo "Installing NDENV"

    anyenv install ndenv
    eval "$(ndenv init - zsh)"

    # Use latest LTS
    ndenv install 8.9.0
    ndenv global 8.9.0

    ndenv rehash

    # Latest npm
    npm install -g npm

    ndenv rehash
}

install
