FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x \
 && apt-get update \
 && apt-get install -y git ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

RUN set -x \
 && git clone https://github.com/neovim/neovim \
 && cd neovim \
 && make CMAKE_BUILD_TYPE=RelWithDebInfo \
 && make install

# Plugins
RUN set -x \
 && mkdir -p $HOME/.local/share/nvim/site/pack/vendor/start \
 && cd $HOME/.local/share/nvim/site/pack/vendor/start \
 && git clone https://github.com/nvim-lua/plenary.nvim.git \
 && git clone https://github.com/neovim/nvim-lspconfig

# go get
RUN set -x \
 && apt install -y software-properties-common \
 && add-apt-repository ppa://longsleep/golang-backports \
 && apt update \
 && apt install -y golang-go

# npm
RUN set -x \
 && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get install -y --no-install-recommends nodejs

# ruby bundler
RUN set -x \
 && apt-get install -y --no-install-recommends ruby ruby-dev \
 && gem install bundler

CMD ["/bin/bash"]
