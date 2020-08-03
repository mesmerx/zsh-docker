FROM alpine:3.7

MAINTAINER Mesmer (https://github.com/mesmerx)

RUN apk update && \
    apk add --no-cache zsh git curl ncurses perl && \
    rm -f /tmp/* /etc/apk/cache/*

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN export TERM=linux

RUN curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

RUN git clone https://github.com/mesmerx/zsh-docker.git
WORKDIR zsh-docker
RUN mv .cache/ /root/ -v
RUN cp .oh-my-zsh/ /root/ -Rv
RUN cp .zplug/ /root/ -Rv
RUN mv .zshrc /root/ -v
RUN cp usr/* /usr/ -Rv

ENV SHELL /bin/zsh

CMD ["zsh", "--version"]
