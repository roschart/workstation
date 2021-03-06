# base OS
FROM alpine:3.13
ENV TZ="Europe/Madrid"
RUN apk add --no-cache \
    ansible \
    bash-completion \
    busybox-extras \
    ca-certificates \
    cargo \
    curl \
    emacs-x11 \
    fish \
    git \
    go \
    htop \
    nodejs \
    npm \
    openssh-client \
    py3-pip \
    python3 \
    rust \
    sqlite \
    texlive \
    tmux \
    tree \
    wget 

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community \
    bat

RUN apk add  -X https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    leiningen

# Packages needed by Hypieron ansible playbooks
RUN pip3 install --upgrade pyvmomi

# Install gopls 
RUN GO111MODULE=on go get golang.org/x/tools/gopls@latest
ENV PATH="${PATH}:/root/go/bin"

# Config emacs
# https://emacs.stackexchange.com/questions/34180/how-can-i-script-emacs-to-install-packages-from-list

COPY .emacs /root/.emacs
#RUN emacs --script /root/.emacs

# Config git
RUN git config --global user.email "jl.balirac@payvision.com"
RUN git config --global user.user  "jl.balirac"

# Config kubectl
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
	kubectl
COPY config /root/.kube/config
RUN /bin/bash -c 'echo ". /etc/bash_completion" >> /root/.bashrc'
RUN /bin/bash -c 'echo "source <(kubectl completion bash)" >> /root/.bashrc'

# Clone my org-roam
RUN ssh-keyscan github.com | ssh-keygen -lf -
## RUN git clone git@github.com:roschart/org-roam.git /root/Workspace/org-roam

# Config entrypoint
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
WORKDIR /root/Workspace
