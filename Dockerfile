ARG GOLANG_VERSION=1.12.5
FROM debian:9.9
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
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

RUN wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.12.5.linux-amd64.tar.gz && rm go1.12.5.linux-amd64.tar.gz

ENV TERM screen-256color
WORKDIR /workspace

COPY bash_profile /root/.bash_profile
COPY gitconfig /root/.gitconfig

CMD ["/bin/bash", "-l", "-c", "tmux"]
