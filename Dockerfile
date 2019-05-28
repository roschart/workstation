FROM debian:9.9
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
 git \
 vim-gtk3 \
 --no-install-recommends
