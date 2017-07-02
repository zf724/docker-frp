FROM alpine

ENV VERSION 0.12.0
ENV IS_SERVER true
#frps.ini
ENV BIND_PORT 7000
ENV SUBDOMAIN_HOST zwise.pw
ENV MAX_POOL_COUNT 10
ENV VHOST_HTTP_PORT 8080
ENV VHOST_HTTPS_PORT 8443
ENV DASHBOARD_PORT 7500
ENV DASHBOARD_USER admin
ENV DASHBOARD_PWD zwise
#frpc.ini
ENV SERVER_ADDR 119.29.185.237
ENV POOL_COUNT 1
ENV SSH_LOCAL_IP 127.0.0.1
ENV SSH_LOCAL_PORT 22
ENV SSH_REMOTE_PORT 2222
ENV WEB01_TYPE https
ENV WEB01_LOCAL_PORT 443
ENV WEB01_SUBDOMAIN nas
ENV WEB02_TYPE http
ENV WEB02_LOCAL_PORT 80
ENV WEB02_SUBDOMAIN www

WORKDIR /root

ADD https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz .

RUN set -xe \
    && tar zxf frp_${VERSION}_linux_amd64.tar.gz \
    && rm frp_${VERSION}_linux_amd64.tar.gz

RUN { \
       echo "[common]"; \
       echo "bind_port = ${BIND_PORT}"; \
       echo "subdomain_host =  ${SUBDOMAIN_HOST}"; \
       echo "vhost_http_port = ${VHOST_HTTP_PORT}"; \
       echo "vhost_https_port = ${VHOST_HTTPS_PORT}"; \
       echo "max_pool_count = ${MAX_POOL_COUNT}"; \
       echo "dashboard_port = ${DASHBOARD_PORT}"; \
       echo "dashboard_user = ${DASHBOARD_USER}"; \
       echo "dashboard_pwd = ${DASHBOARD_PWD}"; \
    } > frps.ini

RUN { \
       echo "[common]"; \
       echo "server_addr = ${SERVER_ADDR}"; \
       echo "bind_port = ${BIND_PORT}"; \
       echo "pool_count = ${POOL_COUNT}"; \
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


ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7000 7500 2222 8080 8443

ENTRYPOINT ["/entrypoint.sh"]
