FROM codercom/code-server:v2
#Instalation with apt-get 
# Node source to isntall LTS 12.x
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \ 
    sudo apt-get update && \
    sudo apt-get install -y haskell-platform  nodejs jq python-dev python-pip \
    # Install lldb, vadimcn.vscode-lldb VSCode extension dependencies
    lldb python3-minimal libpython3.7
# Config git
RUN  git config --global user.email jl.balirac@payvision.com && \
     git config --global user.name jl.balirac  && \
     git config --global credential.helper store
#Install hugo
RUN curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | jq -r '.assets[] | select (.browser_download_url|test(".*extended.*64.*deb")) | .browser_download_url' |  wget -i - && \
    sudo dpkg -i hugo*
# Install ansible
RUN sudo -H pip install ansible
# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/home/coder/.cargo/bin:$PATH"
RUN rustup component add rls rust-analysis rust-src rustfmt clippy 2>&1

#Install code-server extensions
RUN code-server --install-extension justusadam.language-haskell && \
    code-server --install-extension rust-lang.rust && \
	code-server --install-extension bungcip.better-toml && \
	code-server --install-extension vadimcn.vscode-lldb 
# some code-extensions are habing problems, maybe you need go to the termianal 
# and in ~/.local/shared/codeserver/extensions/<extension that fail> and run npm install

WORKDIR /workspace
