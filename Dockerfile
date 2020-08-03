FROM alpine:3.7

MAINTAINER Mesmer (https://github.com/mesmerx)

RUN apk update && \
    apk add --no-cache zsh && \
    rm -f /tmp/* /etc/apk/cache/*

ENV SHELL /bin/zsh

COPY 
CMD ["zsh", "--version"]
