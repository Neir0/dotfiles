# M'dotfiles

## Zsh

```
echo -e "source ~/dotfiles/.zshrc\n\n$(cat ~/.zshrc)" > ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
```

## Oh-my-zsh

```
rm -rf ~/.oh-my-zsh/custom
cp -R ~/dotfiles/ohmyzsh/custom ~/.oh-my-zsh/
```

## Neovim

```
ln -s ~/dotfiles/config/nvim/ ~/.config/nvim
```

## Coc (extensions)

```
rm -R ~/.config/coc/extensions/
ln -s ~/dotfiles/config/coc/extensions ~/.config/coc/extensions
cd ~/.config/coc/extensions/
npm install
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

## Rectangle

Import `RectangleConfig.json`.
