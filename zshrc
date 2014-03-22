ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"

plugins=(git bundler brew gem rbates zsh-syntax-highlighting cp)

export PATH="/usr/local/bin:$PATH"
export EDITOR='vi -w'

source $ZSH/oh-my-zsh.sh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
