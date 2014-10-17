ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"

plugins=(git bundler brew gem rbates zsh-syntax-highlighting cp command-not-found)

<<<<<<< HEAD
export GOROOT="$HOME/utils/go"
export GOPATH="$HOME/git/go"

export M2_HOME="/home/rankun203/utils/apache-maven/"
export TOMCAT_HOME="/home/rankun203/utils/apache-tomcat"

export PATH="/usr/local/bin:$GOROOT/bin:$HOME/bin:$M2_HOME/bin:$PATH"

export EDITOR='vi -w'
=======
export PATH="/usr/local/bin:$HOME/bin:/usr/local/sbin:$PATH"
export EDITOR='vim -w'
>>>>>>> dec0824c5d9f90fab6db2b8f199e4382b04e562a
alias tom="java -jar $HOME/bin/webapp-runner.jar"

source $ZSH/oh-my-zsh.sh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
