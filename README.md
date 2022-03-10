Installation instructions:
```
git clone --recurse-submodules git@github.com:bayardneville/dotfiles.git ~/.dotfiles
ln -sv ~/.dotfiles/{.bash_profile,.bashrc,.ctags,.git-completion.bash,.gitconfig,.gitignore_global,.hushlogin,.vim,.vimrc} ~
```

To set up submodules (only required if `--recurse-submodules` was not used):
```
git submodule update --init --recursive
```
