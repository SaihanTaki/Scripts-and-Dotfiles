#!/bin/bash

BG='\033[46m' # background color
FG='\033[36m' # foreground color (cyan)
BOLD='\033[1m' # Bold text
RESET='\033[0m' # back to default color


git config --global --add safe.directory /code

echo -e "${FG}${BG} Update the system.....${RESET}"
apt-get update -y && apt-get upgrade -y


echo -e "${FG}${BG} Installing oh my zsh......${RESET}"
printf '\n' | sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"


echo -e "${FG}${BG} Installing zsh extensions.......${RESET}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# Clearing the file
cat /dev/null >  ~/.zshrc

# Writing zsh configs
cat <<EOL >> ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HIST_STAMPS="dd.mm.yyyy"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)
source $HOME/.oh-my-zsh/oh-my-zsh.sh

# User configuration
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' formats '(%b) '
precmd() { vcs_info }

setopt PROMPT_SUBST
PROMPT="%F{cyan}%n%f@%F{cyan}%m%f %F{blue}%2~%f %F{red}${vcs_info_msg_0_}%f$ "
RPROMPT="%F{red}%t %w"

EOL



