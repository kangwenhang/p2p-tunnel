FROM alpine:3.13

ARG P2P_MAINTAINER=p2p-tunnel
ARG P2P_URL=https://github.com/kangwenhang/${P2P_MAINTAINER}.git
ARG P2P_BRANCH=master

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PS1="\u@\h:\w \$ " \
    P2P_DIR=/p2p \
    P2P_BRANCH=${P2P_BRANCH} \
    SERVER_CLIENT=server

WORKDIR ${P2P_DIR}

COPY /docker/ /p2p/

RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f bash \
                             libstdc++ \
                             libintl \
                             git \
                             nodejs \
                             npm \
    && rm -rf /var/cache/apk/* \
    && apk update \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && npm install -g pm2 \
    if [ `uname -m` = 'x86_64' ]; \
    then \
      mv /p2p/bin-linux-musl-x64-single.zip /p2p/single.zip \
    elif [ `uname -m` = 'aarch64' ]; \
    then \
      mv /p2p/bin-linux-arm64-single.zip /p2p/single.zip \
    else \
      mv /p2p/bin-linux-arm-single.zip /p2p/single.zip \
    fi \
    && unzip /p2p/single.zip \
    && rm -rf /p2p/single.zip \
    && git clone -b ${P2P_BRANCH} ${P2P_URL} ${P2P_DIR}/version \
    && chmod -R 777 ${P2P_DIR}/version

ENTRYPOINT ["./version/docker-entrypoint.sh"]