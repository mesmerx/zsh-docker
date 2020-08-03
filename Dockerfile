FROM alpine:3.7

MAINTAINER Mesmer (https://github.com/mesmerx)

RUN apk update
RUN apk add --no-cache zsh git curl perl python2 ncurses
RUN rm -f /tmp/* /etc/apk/cache/*

RUN git clone git://github.com/wting/autojump.git
RUN git clone https://github.com/mesmerx/zsh-docker.git

ENV SHELL /bin/zsh
ENV TERM linux

RUN  curl https://raw.githubusercontent.com/zplug/installer/master/installer.zsh --output zplugInstall
RUN zsh zplugInstall
RUN rm zplugInstall

RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh --output nvmInstall
RUN sh nvmInstall 
RUN rm nvmInstall

RUN curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
RUN sh install.sh
RUN rm install.sh

WORKDIR autojump
RUN ./install.py
WORKDIR ..
RUN rm -rvf autojump/ 

WORKDIR zsh-docker
RUN cp .zshrc /root/ -Rv 
RUN cp usr/share /usr/ -Rv 
WORKDIR ..
RUN rm zsh-docker -rfv

CMD ["zsh", "--version"]
