sudo apt update -y
sudo apt upgrade -y
sudo apt install git
sudo apt install zsh
sudo apt install fonts-font-awesome
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip -p ~/Downloads/ -q --show-progress 
mkdir ~/.fonts
unzip ~/Downloads/Meslo.zip -d ~/.fonts/Meslo
fc-cache -fv

sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/Downloads/oh-my-posh-themes.zip -q --show-progress
unzip ~/Downloads/oh-my-posh-themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json

oh-my-posh font install meslo


sudo apt install tmux 
echo "set-option -g default-shell /bin/zsh" >> ~/.tmux.conf
echo "set-option -g status-style 'bg=cyan,fg=black'" >> ~/.tmux.conf