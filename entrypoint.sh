#!/bin/sh
set -e

FILE=/tmp/id_rsa
if [ -f "$FILE" ]; then
  mkdir -p /root/.ssh
  cp $FILE /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
  ssh-keyscan github.com >> ~/.ssh/known_hosts
  echo 'IdentityFile ~/.ssh/id_rsa' >> ~/.ssh/config

  # Import private hyperion key and trust
  # Requirements: have get the hyerion private key from gopass
  # and mount in tme docker run -v $PWD/hyperion.priv.gpg:/tmp/hyperion.priv.gpg
  # gopass hyperion/service_account/hyperion.priv.gpg > hyperion.priv
  #
  FILE=/tmp/hyperion.priv.gpg
  if [ -f "$FILE" ]; then
      echo "#############################################"
      echo "######### Import hyperion secret ############"
      echo "#############################################"

      # import secret and ignore error
      gpg --import $FILE || true
      # trust with ultimate (5)
      gpg --no-tty --command-fd 0 --edit-key hyperion <<EOF
trust
5
y
quit
EOF
      echo "#############################################"
      echo "############## Config Gopass ################"
      echo "#############################################"

      gopass --yes setup --remote git@ssh.dev.azure.com:v3/payvision/Hyperion/secrets --alias hyperion --name hyperion --email hyperion@payvision.com

  fi
fi

FILE=/tmp/id_rsa_hyperion
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

