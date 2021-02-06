#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh

bash ./install.sh

vim +PlugInstall +qall!
vim +NeoBundleInstall +qall!
