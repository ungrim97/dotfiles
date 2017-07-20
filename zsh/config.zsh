export GATLING_HOME="/usr/lib/gatling"

# This allows exclusions and the like in the pattern expansion
setopt EXTENDED_GLOB

# Report the status of background jobs immediately, rather than waiting until
# just before printing a prompt.
setopt NOTIFY

# This option both imports new commands from the history file, and also causes
# your typed commands to be appended to the history file (the latter is like
# specifying INC_APPEND_HISTORY). The history lines are also output with
# timestamps ala EXTENDED_HISTORY (which makes it easier to find the spot where
# we left off reading the file after it gets re-written).
setopt SHARE_HISTORY
unsetopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt IGNORE_EOF

# don't expand aliases _before_ completion has finished
# like: git comm-[tab]
setopt COMPLETE_ALIASES

# vim: set ai et sw=4 syntax=zsh :
