FROM codercom/code-server
RUN sudo apt-get update && \
    sudo apt-get install -y haskell-platform && \
    code-server --install-extension justusadam.language-haskell