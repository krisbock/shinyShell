#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ~/
mkdir .vim
cd .vim
mkdir colors
cd colors
curl -O https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim
cd ~/
cp $DIR/.vimrc ~/

sudo apt-get install -y mc

cp $DIR/.tmux.conf ~/

echo alias mc=\'mc -x\' >> ~/.bashrc
echo export CLICOLOR=1 >> ~/.bashrc
echo source ~/.git-completion.sh >> ~/.bashrc
cat <<'EOF' >> ~/.bashrc
PS1='\[\033[37m\]\W\[\033[0m\]$(__git_ps1 " (\[\033[35m\]%s\[\033[0m\])") \$ '
EOF
echo GIT_PS1_SHOWDIRTYSTATE=1 >> ~/.bashrc
echo GIT_PS1_SHOWSTASHSTATE=1 >> ~/.bashrc
echo GIT_PS1_SHOWUNTRACKEDFILES=1 >> ~/.bashrc
echo GIT_PS1_SHOWUPSTREAM="auto" >> ~/.bashrc

sudo apt-get install -y git bash-completion

# change console colours
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-light
mv dircolors.ansi-light .dircolors
echo 'set bell-style none' >> ~/.inputrc

# add Powerline
sudo apt install -y golang-go
go install github.com/justjanne/powerline-go@latest

cat <<'EOF' >> ~/.bashrc
GOPATH=$HOME/go
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $?)"
}
if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
EOF
