#!/bin/bash
set -e

if [ ! -d ${P2P_DIR}/data ]; then
  echo -e "没有映射${P2P_DIR}/data目录给本容器，请先按教程映射${P2P_DIR}/data目录...\n"
  exit 1
else
  unzip /p2p/single.zip -d /p2p/data
fi

if [[ ${SERVER_CLIENT} == server ]]; then
  echo -e "识别环境变量为server，默认启动服务端\n"
  cd ${P2P_DIR}/data/server
  pm2 start './server.service'
  pm2 log
else
  echo -e "识别环境变量不为server，默认启动客户端\n"
  cd ${P2P_DIR}/data/client
  pm2 start './client.service'
  pm2 log
fi

exec "$@"