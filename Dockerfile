# base OS
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Madrid"
RUN apt-get update -qq && apt-get upgrade -y && apt-get install -qq -y \
	ansible \	
	bash-completion \
	build-essential \
	ca-certificates \
	curl \
	emacs \	
	git \
	htop \
	iputils-ping \
	less \
	openssh-client \
	python3-pyvmomi \
	sqlite3 \
	sudo \
	telnet \
	tmux \
	tree \
	vim-gtk3 \
	wget \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*


# Install golang
RUN wget --no-check-certificate https://golang.org/dl/go1.15.2.linux-amd64.tar.gz -O /tmp/go.tar.gz \
	&& tar -C /usr/local -xzf /tmp/go.tar.gz
ENV PATH="${PATH}:/usr/local/go/bin"
ENV GO111MODULE=on
RUN go get golang.org/x/tools/gopls@latest
ENV PATH="${PATH}:/root/go/bin"

# Config emacs
# https://emacs.stackexchange.com/questions/34180/how-can-i-script-emacs-to-install-packages-from-list

COPY .emacs /root/.emacs
RUN emacs --script /root/.emacs

# Config kubectl
RUN curl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" --output /bin/kubectl
RUN chmod 755 /bin/kubectl
RUN mkdir -p /root/.kube
COPY config /root/.kube/config
RUN /bin/bash -c 'echo ". /etc/bash_completion" >> /root/.bashrc'
RUN /bin/bash -c 'echo "source <(kubectl completion bash)" >> /root/.bashrc'


# Intall node

RUN wget https://nodejs.org/dist/v15.6.0/node-v15.6.0-linux-x64.tar.xz -O /tmp/node.xz \
	&& tar -C /usr/local/ -xavf /tmp/node.xz
ENV PATH="${PATH}:/usr/local/node-v15.6.0-linux-x64/bin/"

# Config git

RUN git config --global user.email "jl.balirac@payvision.com"
RUN git config --global user.user  "jl.balirac"


# Clone my org-roam
RUN ssh-keyscan github.com | ssh-keygen -lf -
## RUN git clone git@github.com:roschart/org-roam.git /root/Workspace/org-roam

# Config entrypoint
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
WORKDIR /root/Workspace
