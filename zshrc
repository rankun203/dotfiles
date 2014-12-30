ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"

SD="/storage/sdcard0"

plugins=(git bundler brew gem rbates zsh-syntax-highlighting cp command-not-found)

export PATH="/usr/local/bin:$HOME/bin:/usr/local/sbin:$PATH"
export EDITOR='vim -w'
export ANDROID='/Applications/android-sdk-macosx'
export ANDROID_HOME=$ANDROID
alias tom="java -jar $HOME/bin/webapp-runner.jar"
alias node="node --harmony"

export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/rankun203/.boot2docker/certs/boot2docker-vm



source $ZSH/oh-my-zsh.sh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export UBIN="/Users/rankun203/git/dotfiles/extra/scripts"
export M2_HOME="/Users/rankun203/tools/apache-maven"

PATH=$PATH:$ANDROID/platform-tools:$ANDROID/tools:$UBIN:$M2_HOME/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting

