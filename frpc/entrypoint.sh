#!/bin/sh

{ \
  echo "[common]"; \
  echo "server_addr = ${COM_SERVER_ADDR}"; \
  echo "server_port = ${COM_SERVER_PORT}"; \
  echo "log_file = ${COM_LOG_FILE}"; \
  echo "log_level = ${COM_LOG_LEVEL}"; \
  echo "log_max_days = ${COM_LOG_MAX_DAYS}"; \
  echo "token = ${COM_TOKEN}"; \
  echo "admin_addr = ${COM_ADMIN_ADDR}"; \
  echo "admin_port = ${COM_ADMIN_PORT}"; \
  echo "admin_user = ${COM_ADMIN_USER}"; \
  echo "admin_pwd = ${COM_ADMIN_PWD}"; \
  echo "pool_count = ${COM_POOL_COUNT}"; \
  echo "user = ${COM_USER}"; \
  echo "tcp_mux = true"; \
  echo "login_fail_exit = false"; \
  echo "protocol = tcp"; \
  echo "tls_enable = true"; \
} > frpc.ini

if [ ${SSH} != "none" ] && [ ${SSH} != "NONE" ];then
{ \
  echo "[${SSH}]"; \
  echo "type = ${SSH_TYPE}"; \
  echo "local_ip = ${SSH_LOCAL_IP}"; \
  echo "local_port = ${SSH_LOCAL_PORT}"; \
  echo "use_encryption = ${SSH_ENCRYPTION}"; \
  echo "use_compression = ${SSH_COMPRESSION}"; \
  echo "remote_port = ${SSH_REMOTE_PORT}"; \
  echo "group = ${COM_USER}_SSH"; \
  echo "group_key = ${COM_USER}_KEY"; \
  echo "health_check_type = tcp"; \
  echo "health_check_timeout_s = 3"; \
  echo "health_check_max_failed = 3"; \
  echo "health_check_interval_s = 10"; \
} >> frpc.ini
fi

if [ ${UDP} != "none" ] && [ ${UDP} != "NONE" ];then
{ \
  echo "[${UDP}]"; \
  echo "type = udp"; \
  echo "local_ip = ${UDP_LOCAL_IP}"; \
  echo "local_port = ${UDP_LOCAL_PORT}"; \
  echo "remote_port = ${UDP_REMOTE_PORT}"; \
  echo "use_encryption = ${UDP_ENCRYPTION}"; \
  echo "use_compression = ${UDP_COMPRESSION}"; \
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
