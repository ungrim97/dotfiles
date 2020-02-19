set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

ANYENV_BASE="${HOME}/.anyenv"
export PATH="${ANYENV_BASE}/bin:$PATH"

install_anyenv () {
    if ! is_git_command_available
    then
        echo "Unable to install anyenv... git command not found" >&2
        return ${STATUS_ERROR}
    fi

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
    anyenv install --init

    _install_plugins || return ${STATUS_ERROR}

}

_install_plugins () {
    install_env_plugin 'https://github.com/znz/anyenv-update.git' 'anyenv-update'
    install_env_plugin 'https://github.com/znz/anyenv-git.git' 'anyenv-git'
}

install_env_plugin () {
    plugin_dir="${ANYENV_BASE}/plugins"

    if [ $3 ]
    then
        plugin_dir="${ANYENV_BASE}/envs/$3/plugins/"
    fi

    if [ ! -e $plugin_dir ]
    then
        mkidr -p $plugin_dir
    fi

    if [ -e "${plugin_dir}/${2}" ]
    then
        return
    fi

    echo "Fetching $2"
    git clone --depth 1 $1 "${plugin_dir}/${2}"
}

install_env () {
    install_anyenv

    if [ -e "${ANYENV_BASE}/envs/${1}" ]
    then
        return
    fi

    anyenv install $1
    install_env_plugin 'https://github.com/momo-lab/xxenv-latest.git' 'xxenv-latest' $1
}
