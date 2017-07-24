set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

ANYENV_BASE="${HOME}/.anyenv"

install () {
    if ! is_git_command_available
    then
        echo "Unable to install zsh... git command not found" >&2
        return ${STATUS_ERROR}
    fi

    install_anyenv  || return ${STATUS_ERROR}
    install_plugins || return ${STATUS_ERROR}
    install_plenv   || return ${STATUS_ERROR}
    install_ndenv   || return ${STATUS_ERROR}
    install_rbenv   || return ${STATUS_ERROR}
    install_pyenv   || return ${STATUS_ERROR}
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

    git clone --quiet --depth 1 https://github.com/riywo/anyenv $ANYENV_BASE
    exec $SHELL -l
}

install_plugins () {
    if [ ! -e "${ANYENV_BASE}/plugins" ]
    then
        mkdir "${ANYENV_BASE}/plugins"
    fi

    if [ ! -e "${ANYENV_BASE}/plugins/anyenv-update" ]
    then
        git clone --quiet --depth 1 https://github.com/znz/anyenv-update.git "${ANYENV_BASE}/plugins/anyenv-update"
    fi

    if [ ! -e "${ANYENV_BASE}/plugins/anyenv-git" ]
    then
        git clone --quiet --depth 1 https://github.com/znz/anyenv-git.git "${ANYENV_BASE}/plugins/anyenv-git"
    fi
}

install_plenv () {
    # Don't install if already installed
    if [ -e "${ANYENV_BASE}/envs/plenv" ]
    then
        return
    fi

    # Don't install if perlbrew is in use
    if [ -e "${HOME}/.perlbrew" ]
    then
        return
    fi

    anyenv install plenv
    exec $SHELL -l

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

    anyenv install ndenv
    exec $SHELL -l

    # Use latest LTS
    ndenv install 6.9.5
    ndenv global 6.9.5

    ndenv rehash

    npm insall -g ember-cli

    ndenv rehash
}

install_rbenv () {
    # Don't install if already installed
    if [ -e "${ANYENV_BASE}/envs/rbenv" ]
    then
        return
    fi

    anyenv install rbenv
    exec $SHELL -l

    # Use latest
    rbenv install 2.4.1
    rbenv global 2.4.1

    rbenv rehash
}

install_pyenv () {
    # Don't install if already installed
    if [ -e "${ANYENV_BASE}/envs/pyenv" ]
    then
        return
    fi

    anyenv install pyenv
    exec $SHELL -l

    # Use latest
    pyenv install 3.6.2
    pyenv install 2.7.9
    pyenv global 3.6.2 2.7.9 system

    pyenv rehash
}

install
