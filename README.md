# zsh-bd

This is a reimplementation of
[vigneshwaranr/bd](https://github.com/vigneshwaranr/bd) that utilizes the power
of the zsh shell.

## Install

All you need to do is to source `bd.zsh`. Here's the manual installation

    mkdir -p $HOME/.zsh/plugins/bd
    curl https://raw.github.com/Tarrasch/zsh-bd/master/bd.zsh > $HOME/.zsh/plugins/bd/bd.zsh
    print -- "\n# zsh-bd\n. \$HOME/.zsh/plugins/bd/bd.zsh" >> $HOME/.zshrc

### [Antigen](https://github.com/zsh-users/antigen)

If you prefer antigen over manual installation

    antigen-bundle Tarrasch/zsh-bd

## Usage

    $ mkdir -p a/b/c/d
    $ cd a/b/c/d
    $ bd b
    $ ls
    c

## Thanks

Thanks to
[@vigneshwaranr](https://github.com/vigneshwaranr)
for inspiring me to do a zsh version.
