ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"

plugins=(git bundler brew gem rbates zsh-syntax-highlighting cp command-not-found)

export GOROOT="$HOME/utils/go"
export GOPATH="$HOME/git/go"
export PATH="/usr/local/bin:$GOROOT/bin:$HOME/bin:$PATH"
export EDITOR='vi -w'
alias tom="java -jar $HOME/bin/webapp-runner.jar"

source $ZSH/oh-my-zsh.sh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
