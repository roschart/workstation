ARG GOLANG_VERSION=1.12.5

# install vim plugins
FROM ubuntu:18.10 as vim_plugins_builder
RUN apt-get update && apt-get install -y git ca-certificates
RUN mkdir -p /root/.vim/plugged && cd /root/.vim/plugged && \ 
	git clone 'https://github.com/fatih/vim-go' && \
	git clone 'https://github.com/scrooloose/nerdtree'

#base
FROM debian:9.9
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
    curl \
    git \
    locales \
    neovim \
    tmux \
    vim-gtk3 \
    wget \
    --no-install-recommends

RUN echo "LC_ALL=EN_US.UTF8" >> /etc/envirotment && \
    echo  "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf && \
    locale-gen en_us.UTF-8


# Config go
RUN wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.12.5.linux-amd64.tar.gz && rm go1.12.5.linux-amd64.tar.gz && \
    mkdir /workspace/ && mkdir /workspace/go
ENV GOPATH=/workspace/go


ENV TERM screen-256color

WORKDIR /workspace

COPY bash_profile /root/.bash_profile
COPY gitconfig /root/.gitconfig
COPY vimrc /root/.vimrc


# vim plugins
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY --from=vim_plugins_builder /root/.vim/plugged /root/.vim/plugged

# config nvim
RUN mkdir /root/.config && \
    ln -s /root/.vim /root/.config/nvim && \
    ln -s /root/.vimrc ~/.config/nvim/init.vim

ENTRYPOINT ["/bin/bash",  "-l", "-c", "tmux"]
