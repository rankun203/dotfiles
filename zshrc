ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"

plugins=(git bundler brew gem rbates zsh-syntax-highlighting cp command-not-found)

export PATH="/usr/local/bin:$HOME/bin:/usr/local/sbin:$PATH"
export EDITOR='vim -w'
alias tom="java -jar $HOME/bin/webapp-runner.jar"

source $ZSH/oh-my-zsh.sh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
