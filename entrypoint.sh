#!/bin/sh
set -e

FILE=/tmp/id_rsa
if [ -f "$FILE" ]; then
  mkdir -p /root/.ssh
  cp $FILE /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
  ssh-keyscan github.com >> ~/.ssh/known_hosts
  echo 'IdentityFile ~/.ssh/id_rsa' >> ~/.ssh/config
fi

FILE=/tmp/hyperion.priv
if [ -f "$FILE" ]; then
  mkdir -p /root/.ssh
  cp $FILE  /root/.ssh/hyperion.priv
  chmod 600 /root/.ssh/hyperion.priv
  echo 'IdentityFile ~/.ssh/hyperion.priv' >> ~/.ssh/config
fi

# if no command the execute fish as default
if [ $# -eq 0 ]
  then
    exec zsh
  else 
    exec $@
fi

