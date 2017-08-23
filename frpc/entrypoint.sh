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

if [ ${SSH} != "none" ] && [ ${SSH} != "NONE" ];then
{ \
  echo "[${SSH}]"; \
  echo "type = tcp"; \
  echo "local_ip = ${SSH_LOCAL_IP}"; \
  echo "local_port = ${SSH_LOCAL_PORT}"; \
  echo "remote_port = ${SSH_REMOTE_PORT}"; \
  echo "use_encryption = ${USE_ENCRYPTION}"; \
  echo "use_compression = ${USE_COMPRESSION}"; \
} >> frpc.ini
fi

if [ ${WEB01} != "none" ] && [ ${WEB01} != "NONE" ];then
{ \
  echo "[${WEB01}]"; \
  echo "type = ${WEB01_TYPE}"; \
  echo "local_ip = ${WEB01_LOCAL_IP}"; \
  echo "local_port = ${WEB01_LOCAL_PORT}"; \
  echo "use_encryption = ${USE_ENCRYPTION}"; \
  echo "use_compression = ${USE_COMPRESSION}"; \
  echo "subdomain = ${WEB01_SUBDOMAIN}"; \
} >> frpc.ini
fi

if [ ${WEB02} != "none" ] && [ ${WEB02} != "NONE" ];then
{ \
  echo "[${WEB02}]"; \
  echo "type = ${WEB02_TYPE}"; \
  echo "local_ip = ${WEB02_LOCAL_IP}"; \
  echo "local_port = ${WEB02_LOCAL_PORT}"; \
  echo "use_encryption = ${USE_ENCRYPTION}"; \
  echo "use_compression = ${USE_COMPRESSION}"; \
  echo "subdomain = ${WEB02_SUBDOMAIN}"; \
} >> frpc.ini
fi

if [ ${PROXY} != "none" ] && [ ${PROXY} != "NONE" ];then
{ \
  echo "[${PROXY}]"; \
  echo "type = tcp"; \
  echo "remote_port = ${PROXY_REMOTE_PORT}"; \
  echo "plugin = ${PROXY_PLUGIN}"; \
  echo "plugin_http_user = ${PROXY_HTTP_USER}"; \
  echo "plugin_http_passwd = ${PROXY_HTTP_PASSWD}"; \
} >> frpc.ini
fi

./frpc -c frpc.ini
