FROM alpine

ENV VERSION 0.26.0
#frpc.ini
ENV SERVER_ADDR 119.29.185.237
ENV SERVER_PORT 7000
ENV LOG_FILE ./frp.log
ENV LOG_LEVEL info
ENV LOG_MAX_DAYS 7
ENV PRIVILEGE_TOKEN zwise
ENV POOL_COUNT 1
#ssh
ENV SSH none
ENV SSH_LOCAL_IP 127.0.0.1
ENV SSH_LOCAL_PORT 22
ENV SSH_TYPE tcp
ENV SSH_REMOTE_PORT 2222
ENV USE_ENCRYPTION false
ENV USE_COMPRESSION true
#web01
ENV WEB01 none
ENV WEB01_TYPE https
ENV WEB01_LOCAL_IP 127.0.0.1
ENV WEB01_LOCAL_PORT 443
ENV WEB01_SUBDOMAIN nas
#web02
ENV WEB02 none
ENV WEB02_TYPE http
ENV WEB02_LOCAL_IP 127.0.0.1
ENV WEB02_LOCAL_PORT 80
ENV WEB02_SUBDOMAIN www
#proxy
ENV PROXY none
ENV PROXY_REMOTE_PORT 1080
ENV PROXY_PLUGIN socks5
ENV PROXY_HTTP_USER guest
ENV PROXY_HTTP_PASSWD zwise

WORKDIR /root

ADD https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz .

RUN set -xe \
    && tar zxf frp_${VERSION}_linux_amd64.tar.gz \
    && rm frp_${VERSION}_linux_amd64.tar.gz \
    && mv frp_${VERSION}_linux_amd64/frpc . \
    && rm -rf frp_${VERSION}_linux_amd64

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
