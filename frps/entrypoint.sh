#!/bin/sh

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
