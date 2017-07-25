source ~/.antigen.zsh

[ -e ~/.antigen-plugins.zsh ] && source ~/.antigen-plugins.zsh
antigen bundle Tarrasch/zsh-colors
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen apply
