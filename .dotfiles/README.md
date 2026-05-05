# .dotfiles
## Steps to get up and running with neovim 
https://github.com/hampusek/ansible
https://github.com/hampusek/.dotfiles

1. Install neovim
https://github.com/neovim/neovim/wiki/Installing-Neovim
2. Install vim-plug
https://github.com/junegunn/vim-plug
3. Create python venv for nvim
mkdir ~/.local/venv
python3 -m venv ~/.local/nvim
4. Install python dependencies
~/.local/venv/nvim/bin/python3 -m pip install pynvim
~/.local/venv/nvim/bin/python3 -m pip install pyright
5. alias vim= which nvim
5b. ln -s ~/.dotfiles/nvim/.config/nvim ~/.config/nvim
6. Open vim and run 
:PlugInstall
7. Install ripgrep and sharkdp on your system
https://github.com/BurntSushi/ripgrep
https://github.com/sharkdp/fd#installation

## Steps to get up and running with minimal vim
1. Link .dotfiles/minimal_vim/.vimrc to ~/.vimrc

ln ~/.dotfiles/minimal_vim/.vimrc ~/.vimrc

## How to configure ipython
- Install by pip install ipython
- cp ipython/ipython_config.py into ~/.ipython/profile_default/ 

