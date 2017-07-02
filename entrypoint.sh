#!/bin/sh

if [ ${IS_SERVER} == true ];then
  { \
       echo "[common]"; \
       echo "bind_addr = 0.0.0.0"; \
       echo "bind_port = ${BIND_PORT}"; \
       echo "vhost_http_port = ${VHOST_HTTP_PORT}"; \
       echo "vhost_https_port = ${VHOST_HTTPS_PORT}"; \
       echo "dashboard_port = ${DASHBOARD_PORT}"; \
       echo "dashboard_user = ${DASHBOARD_USER}"; \
       echo "dashboard_pwd = ${DASHBOARD_PWD}"; \
       echo "log_file = ${LOG_FILE}"; \
       echo "log_level = ${LOG_LEVEL}"; \
       echo "log_max_days = ${LOG_MAX_DAYS}"; \
       echo "privilege_token = ${PRIVILEGE_TOKEN}"; \
       echo "max_pool_count = ${MAX_POOL_COUNT}"; \
       echo "authentication_timeout = ${AUTHENTICATION_TIMEOUT}"; \
       echo "subdomain_host =  ${SUBDOMAIN_HOST}"; \
       echo "tcp_mux = true"; \
  } > frps.ini

  mv frp_${VERSION}_linux_amd64/frps .
  rm -rf frp_${VERSION}_linux_amd64

  ./frps -c frps.ini
else
  { \
       echo "[common]"; \
       echo "server_addr = ${SERVER_ADDR}"; \
       echo "server_port = ${BIND_PORT}"; \
       echo "log_file = ${LOG_FILE}"; \
       echo "log_level = ${LOG_LEVEL}"; \
       echo "log_max_days = ${LOG_MAX_DAYS}"; \
       echo "privilege_token = ${PRIVILEGE_TOKEN}"; \
       echo "pool_count = ${POOL_COUNT}"; \
       echo "tcp_mux = true"; \
       echo "[ssh]"; \
       echo "type = tcp"; \
       echo "local_ip = ${SSH_LOCAL_IP}"; \
       echo "local_port = ${SSH_LOCAL_PORT}"; \
       echo "remote_port = ${SSH_REMOTE_PORT}"; \
       echo "use_encryption = true"; \
       echo "use_compression = true"; \
       echo "[web01]"; \
       echo "type = ${WEB01_TYPE}"; \
       echo "local_port = ${WEB01_LOCAL_PORT}"; \
       echo "subdomain = ${WEB01_SUBDOMAIN}"; \
       echo "[web02]"; \
       echo "type = ${WEB02_TYPE}"; \
       echo "local_port = ${WEB02_LOCAL_PORT}"; \
       echo "subdomain = ${WEB02_SUBDOMAIN}"; \
  } > frpc.ini

  mv frp_${VERSION}_linux_amd64/frpc .
  rm -rf frp_${VERSION}_linux_amd64

  ./frpc -c frpc.ini
fi
