# vim-simple-bdd

Generate methods easily for [simple_bdd][] in Vim.

## Installation

It is recommended to use a plugin manager for Vim. Here are some examples:

#### [Vundle][]
    Plugin 'mdelillo/vim-simple-bdd'

#### [NeoBundle][]
    NeoBundle 'mdelillo/vim-simple-bdd'

#### [Pathogen][]
    git clone https://github.com/mdelillo/vim-simple-bdd.git ~/.vim/bundle/vim-simple-bdd

## Usage

Run the `:SimpleBDD` command on a single line to convert the simple_bdd statement into a method declaration and begin inserting.

![alt tag](http://i.imgur.com/1yV26x1.gif)

Run the `:SimpleBDD` command on a visual selection or range of lines to convert multiple simple_bdd statements into method declarations.

![alt tag](http://i.imgur.com/iwMk1WM.gif)


[simple_bdd]: https://github.com/robb1e/simple_bdd
[Vundle]: https://github.com/gmarik/Vundle.vim
[NeoBundle]: https://github.com/Shougo/neobundle.vim
[Pathogen]: https://github.com/tpope/vim-pathogen
