FROM debian:9.9
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
 git \
 locales \
 tmux \
 vim-gtk3 \
 --no-install-recommends

RUN echo "LC_ALL=EN_US.UTF8" >> /etc/envirotment && \
 echo  "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
 echo "LANG=en_US.UTF-8" >> /etc/locale.conf && \
 locale-gen en_us.UTF-8

WORKDIR /workspace

COPY bash_profile /root/.bash_profile
