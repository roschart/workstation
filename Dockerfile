FROM codercom/code-server:v2
# Node source to isntall LTS 12.x
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \ 
    sudo apt-get update && \
    sudo apt-get install -y haskell-platform  nodejs && \
    code-server --install-extension justusadam.language-haskell
