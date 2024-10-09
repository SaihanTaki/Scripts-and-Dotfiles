#!/bin/bash

BG='\033[46m' # background color (cyan)
FG='\033[36m' # foreground color (cyan)
BOLD='\033[1m' # Bold text
RESET='\033[0m' # back to default color


echo -e "${FG}${BOLD} Adding swap space....${RESET}"
fallocate -l 4G /swapfile
dd if=/dev/zero of=/swapfile bs=4096k count=1048
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile


echo -e "${FG}${BOLD} Update the system.....${RESET}"
apt update -y && apt upgrade -y


echo -e "${FG}${BOLD} Adding some ppa repositories.....${RESET}"
apt install software-properties-common -y
printf '\n' | add-apt-repository ppa:zhangsongcui3371/fastfetch 
printf '\n' | add-apt-repository ppa:deadsnakes/ppa 


echo -e "${FG}${BOLD} Installing packages.....${RESET}"
apt install -y gcc git zip duf bat zsh curl wget make cron tmux micro fastfetch python3.10 python3.10-venv python3-venv 


echo -e "${FG}${BOLD} Installing btop using snap.....${RESET}"
snap install btop

    
echo -e "${FG}${BOLD} Installing oh my zsh......${RESET}"
printf '\n' | sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"


echo -e "${FG}${BOLD} Installing zsh extensions.......${RESET}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


echo -e "${FG}${BOLD} Writing .zshrc file.......${RESET}"
# Clearing the file
cat /dev/null >  ~/.zshrc
# Start of zsh configs
cat <<EOL >> ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HIST_STAMPS="dd.mm.yyyy"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)
source $HOME/.oh-my-zsh/oh-my-zsh.sh

EOL
# End of zsh configs


echo -e "${FG}${BOLD} Configuring tmux......${RESET}"
echo "set-option -g default-shell /bin/zsh" >> ~/.tmux.conf
echo "set-option -g status-style 'bg=cyan,fg=black'" >> ~/.tmux.conf


echo -e "${FG}${BOLD} Installing Docker.....${RESET}"
# Add Docker's official GPG key:
apt install ca-certificates -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

