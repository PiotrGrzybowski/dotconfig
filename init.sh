# Use an official Debian 11 image as the base
FROM debian:11

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TZ=Europe/Warsaw
# Install necessary packages
RUN apt-get update && apt-get install -y curl git zsh fzf ripgrep stow tmux wget python3-pip python3-venv \
    build-essential tree git xclip nodejs npm tzdata ninja-build gettext libtool libtool-bin \
    autoconf automake cmake g++ pkg-config zip unzip fd-find \
    libssl-dev zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev libffi-dev wget

RUN git clone https://github.com/neovim/neovim.git /opt/neovim
WORKDIR /opt/neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/usr/local
RUN make
RUN make install

# Set zsh as the default shell using chsh
RUN chsh -s $(which zsh)

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone zsh-syntax-highlighting and zsh-autosuggestions repositories
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Install thefuck using pip
RUN pip3 install thefuck

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs

# Install Python 3.10
RUN wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz && \
    tar -xvf Python-3.10.11.tgz && \
    cd Python-3.10.11 && \
    ./configure --enable-optimizations && \
    make -j 8 && \
    make altinstall

# Install Python 3.11
RUN wget https://www.python.org/ftp/python/3.11.3/Python-3.11.3.tgz && \
    tar -xvf Python-3.11.3.tgz && \
    cd Python-3.11.3 && \
    ./configure --enable-optimizations && \
    make -j 8 && \
    make altinstall

RUN apt-get install -y golang cargo rustc default-jdk

# Add plugins to zshrc file
RUN sed -i -E 's/^plugins=\((.*)\)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions colorize thefuck \1)/' ~/.zshrc
RUN echo "export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=226'" >> ~/.zshrc
RUN echo  "export TERM=xterm-256color" >> ~/.zshrc
RUN echo "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'" > ~/init_nvim.sh && chmod u+x /root/init_nvim.sh
COPY .tmux.conf /root/.tmux.conf

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

COPY nvim /root/.config/nvim


#RUN dpkg --remove --force-remove-reinstreq libnode-dev
#RUN dpkg --remove --force-remove-reinstreq libnode72:arm64
WORKDIR /root
# Set up tmux with zsh
CMD ["/bin/zsh"]
