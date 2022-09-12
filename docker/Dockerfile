FROM alpine:3.13

ARG P2P_MAINTAINER=p2p-tunnel
ARG P2P_URL=https://github.com/kangwenhang/${P2P_MAINTAINER}.git
ARG P2P_BRANCH=master
EXPOSE 5410/udp 59410/tcp

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=zh_CN.UTF-8 \
    SHELL=/bin/bash \
    PS1="\u@\h:\w \$ " \
    P2P_DIR=/p2p \
    P2P_BRANCH=${P2P_BRANCH}

WORKDIR ${P2P_DIR}

COPY /docker/single.zip /p2p/single.zip

RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f bash \
                             libstdc++ \
                             libintl \
                             git \
                             nodejs \
    && rm -rf /var/cache/apk/* \
    && apk update \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && npm install -g pm2 \
    && unzip /p2p/single.zip \
    && git clone -b ${P2P_BRANCH} ${P2P_URL} ${P2P_DIR}/version 

ENTRYPOINT ["./version/docker/docker-entrypoint.sh"]