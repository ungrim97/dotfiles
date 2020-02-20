# VI Mode
bindkey -v

# Requires https://github.com/zsh-users/zsh-history-substring-search
# (handled by antigen)
# This allows the entire line to be used as a search when pressing up or down.
# Move to the start of the line to prevent this.
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# This allows control-r to be used to perform a reverse search
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

bindkey -M viins '^t' push-line
bindkey -M vicmd '^t' push-line

# This allows alt-. to insert the last word of the last command (i.e. !$)
bindkey "^[." insert-last-word
bindkey "®"   insert-last-word

# Enter command mode and v will provide a full $EDITOR for commands
# See https://news.ycombinator.com/item?id=5508341
# http://stackoverflow.com/questions/890620/unable-to-have-bash-like-c-x-e-in-zsh
# http://nuclearsquid.com/writings/edit-long-commands/
# etc etc
autoload -U         edit-command-line
zle      -N         edit-command-line
bindkey  -M vicmd v edit-command-line

# N.B. The builtin fc (fix command) can be used to edit and rerun history

# Map control-p to the vim ctrlp command. Will open vim and run ctrlp.
# This is lovely and dirty - will wipe out the current line.
function vim-ctrlp () {
    BUFFER='vim "+:Unite file_rec/async"'
    zle accept-line
}
zle -N                vim-ctrlp
bindkey -M viins '^P' vim-ctrlp

bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[3~" delete-char

# vim: set ai et sw=4 syntax=zsh :
