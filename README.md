# Josh's dot files

I don't intend for my dot files to be usable for the general public. However, you may find some use of them in configuring your own system. Software is a series of esoteria, arcane knowledge that must be found on pull requests, ancient mailing lists, the hearsay of internet strangers...sometimes you need a little help.

# Organization

Some people manage their dot files with programs such as [GNU Stow](https://www.gnu.org/software/stow/). I don't. I usually `cp -ri` whatever I need.

## `/etc`

Several of my configs are entirely unused, but at one point I have used them and thus keep those for posterity in case I need them again. Other configs are useless because my distro's defaults cover them.

Certain files may be outright incorrect or deprecated. I intend to remove those as I find them, but you surely should not copy blindly.

## `~/`

My home directory configs are my personal choices so, like everything else, you must appraise them prior to copying. For color schemes, I have a mix of [Catppuccin](https://catppuccin.com) and [Dracula](https://draculatheme.com/). Everything is Catppuccin where possible, but I have stray Draculas where setting Catppuccin is too annoying (IPython). My Bash and Fish profiles are centered around Wayland and Pipewire. 

Color schemes are either links to cloned repos or installed via a package manager.

## neovim

My main editor is [neovim](https://neovim.io/) which I've configured in Lua.
