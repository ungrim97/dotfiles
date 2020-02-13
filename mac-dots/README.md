dot files
=========

This is my current set of dotfiles.

Requires Python 3


Installation
------------

	mac-dots/script/bootstrap
	mac-dots/script/install

The install command allows them to be easily installed on any machine.
The install command does not delete any files, and will indicate any
existing files. This allows you to delete (or move) some files and then
try out some specific parts of this.

This works best on mate-terminal. Konqueror has also been tested, but
some minor graphical artifacts with the tmux powerline were found.


Modules
-------

Each folder defines the installable files using the files file. The files
file contains a list of files, relative to the current directory, and the
destination. Each listed file (or folder) will be linked to the
destination.
