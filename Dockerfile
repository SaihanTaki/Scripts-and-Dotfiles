FROM ubuntu 

# Basic Installs
RUN apt-get update && apt upgrade -y \
    && apt-get install -y \
    gcc \
    git \ 
    zip \
    duf \
    bat \
    zsh \
    curl \
    wget \
    make \
    cron \
    tmux \
    micro \
    python3-venv \
    software-properties-common \
    && add-apt-repository ppa:zhangsongcui3371/fastfetch \
    && apt-get install fastfetch

WORKDIR /code
COPY dockershell.sh ./
RUN chmod +x dockershell.sh && ./dockershell.sh

ENV TZ=Asia/Dhaka

