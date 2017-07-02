FROM alpine

ENV VERSION 0.12.0
ENV IS_SERVER true
#frps.ini
ENV BIND_PORT 7000
ENV VHOST_HTTP_PORT 8080
ENV SUBDOMAIN_HOST zwise.pw
ENV MAX_POOL_COUNT 10
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

ADD https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz /root

RUN set -xe \
    && tar zxf /root/frp_${VERSION}_linux_amd64.tar.gz /root

RUN set -xe \
    && touch /root/frps.ini \
    && sed -i '$a [common]' \
           -i '$a bind_port = ${BIND_PORT}' \
           -i '$a vhost_http_port = ${VHOST_HTTP_PORT}' \
           -i '$a subdomain_host =  ${SUBDOMAIN_HOST}' \
           -i '$a max_pool_count = ${MAX_POOL_COUNT}' \
           -i '$a dashboard_port = ${DASHBOARD_PORT}' \
           -i '$a dashboard_user = ${DASHBOARD_USER}' \
           -i '$a dashboard_pwd = ${DASHBOARD_PWD}' \
           /root/frps.ini

RUN set -xe \
    && touch /root/frpc.ini \
    && sed -i '$a [common]' \
           -i '$a server_addr = ${SERVER_ADDR}' \
           -i '$a bind_port = ${BIND_PORT}' \
           -i '$a pool_count = ${POOL_COUNT}' \
           -i '$a [ssh]' \
           -i '$a type = tcp' \
           -i '$a local_ip = ${SSH_LOCAL_IP}' \
           -i '$a local_port = ${SSH_LOCAL_PORT}' \
           -i '$a remote_port = ${SSH_REMOTE_PORT}' \
           -i '$a use_encryption = true' \
           -i '$a use_compression = true' \
           -i '$a [web01]' \
           -i '$a type = ${WEB01_TYPE}' \
           -i '$a local_port = ${WEB01_LOCAL_PORT}' \
           -i '$a subdomain = ${WEB01_SUBDOMAIN}' \
           -i '$a [web02]' \
           -i '$a type = ${WEB02_TYPE}' \
           -i '$a local_port = ${WEB02_LOCAL_PORT}' \
           -i '$a subdomain = ${WEB02_SUBDOMAIN}' \
           /root/frpc.ini


ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /root
EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
