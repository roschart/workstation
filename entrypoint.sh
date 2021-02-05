#!/bin/sh
set -e

FILE=/tmp/id_rsa
if [ -f "$FILE" ]; then
  mkdir -p /root/.ssh
  cp $FILE /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
  ssh-keyscan github.com >> ~/.ssh/known_hosts
fi

# if no command the execute ash as default
if [ $# -eq 0 ]
  then
    exec bash
  else 
    exec $@
fi

