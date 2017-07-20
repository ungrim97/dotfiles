if [[ -e $HOME/.anyenv ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

if [[ -e $HOME/.anyenv/envs/plenv ]]; then
    eval "$(plenv init -)"
fi

if [[ -e $HOME/.anyenv/envs/rbenv ]]; then
    eval "$(rbenv init -)"
fi

if [[ -e $HOME/.anyenv/envs/ndenv ]]; then
    eval "$(ndenv init -)"
fi
