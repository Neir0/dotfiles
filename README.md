# M'dotfiles

## Zsh

```
echo -e "source ~/dotfiles/.zshrc\n\n$(cat ~/.zshrc)" > ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
```

## Oh-my-zsh

```
rm -rf ~/.oh-my-zsh/custom
ln -s ~/dotfiles/ohmyzsh/custom ~/.oh-my-zsh/custom
```

## Neovim

```
ln -s ~/dotfiles/config/nvim/ ~/.config/nvim
```

## iTerm2

Go to `Preferences > General > Preferences` and set path to `~/dotfiles/iterm2/`

## Tmux

```
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
```

## Neomutt

Add account configuration to `~/dotfiles/config/mutt/account`.

```
ln -s ~/dotfiles/config/mutt/ ~/.config/mutt
```

## Ag

```
ln -s ~/dotfiles/.agignore ~/.agignore
```
