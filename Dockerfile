FROM codercom/code-server:v2
#Instalation with apt-get 
# Node source to isntall LTS 12.x
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \ 
    sudo apt-get update && \
    sudo apt-get install -y haskell-platform  nodejs jq python-dev python-pip && \
    code-server --install-extension justusadam.language-haskell
# Config git
RUN  git config --global user.email jl.balirac@payvision.com && \
     git config --global user.name jl.balirac  && \
     git config --global credential.helper store
#Install huog
RUN curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | jq -r '.assets[] | select (.browser_download_url|test(".*extended.*64.*deb")) | .browser_download_url' |  wget -i - && \
    sudo dpkg -i hugo*
# Install ansible
RUN sudo -H pip install ansible
    

