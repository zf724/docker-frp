#!/bin/sh

{ \
  echo "[common]"; \
  echo "server_addr = ${SERVER_ADDR}"; \
  echo "server_port = ${SERVER_PORT}"; \
  echo "log_file = ${LOG_FILE}"; \
  echo "log_level = ${LOG_LEVEL}"; \
  echo "log_max_days = ${LOG_MAX_DAYS}"; \
  echo "privilege_token = ${PRIVILEGE_TOKEN}"; \
  echo "pool_count = ${POOL_COUNT}"; \
  echo "tcp_mux = true"; \
} > frpc.ini

if [ ${SSH} == "true" ];then
{ \
  echo "[${SSH_NAME}]"; \
  echo "type = tcp"; \
  echo "local_ip = ${SSH_LOCAL_IP}"; \
  echo "local_port = ${SSH_LOCAL_PORT}"; \
  echo "remote_port = ${SSH_REMOTE_PORT}"; \
  echo "use_encryption = ${USE_ENCRYPTION}"; \
  echo "use_compression = ${USE_COMPRESSION}"; \
} >> frpc.ini
fi

if [ ${WEB01} == "true" ];then
{ \
  echo "[${WEB01_NAME}]"; \
  echo "type = ${WEB01_TYPE}"; \
  echo "local_ip = ${WEB01_LOCAL_IP}"; \
  echo "local_port = ${WEB01_LOCAL_PORT}"; \
  echo "use_encryption = ${USE_ENCRYPTION}"; \
  echo "use_compression = ${USE_COMPRESSION}"; \
  echo "subdomain = ${WEB01_SUBDOMAIN}"; \
} >> frpc.ini
fi

if [ ${WEB02} == "true" ];then
{ \
  echo "[${WEB02_NAME}]"; \
  echo "type = ${WEB02_TYPE}"; \
  echo "local_ip = ${WEB02_LOCAL_IP}"; \
  echo "local_port = ${WEB02_LOCAL_PORT}"; \
  echo "use_encryption = ${USE_ENCRYPTION}"; \
  echo "use_compression = ${USE_COMPRESSION}"; \
  echo "subdomain = ${WEB02_SUBDOMAIN}"; \
} >> frpc.ini
fi

if [ ${PROXY} == "true" ];then
{ \
  echo "[${PROXY_NAME}]"; \
  echo "type = tcp"; \
  echo "remote_port = ${PROXY_REMOTE_PORT}"; \
  echo "plugin = http_proxy"; \
  echo "plugin_http_user = ${PROXY_HTTP_USER}"; \
  echo "plugin_http_passwd = ${PROXY_HTTP_PASSWD}"; \
} >> frpc.ini
fi

mv frp_${VERSION}_linux_amd64/frpc .
rm -rf frp_${VERSION}_linux_amd64

./frpc -c frpc.ini
