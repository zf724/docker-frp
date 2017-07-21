FROM alpine

ENV VERSION 0.13.0
#frps.ini
ENV BIND_PORT 7000
ENV VHOST_HTTP_PORT 80
ENV VHOST_HTTPS_PORT 443
ENV DASHBOARD_PORT 7500
ENV DASHBOARD_USER admin
ENV DASHBOARD_PWD zwise
ENV LOG_FILE ./frp.log
ENV LOG_LEVEL info
ENV LOG_MAX_DAYS 7
ENV PRIVILEGE_TOKEN zwise
ENV MAX_POOL_COUNT 10
ENV AUTHENTICATION_TIMEOUT 120
ENV SUBDOMAIN_HOST zwise.pw

WORKDIR /root

ADD https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz .

RUN set -xe \
    && tar zxf frp_${VERSION}_linux_amd64.tar.gz \
    && rm frp_${VERSION}_linux_amd64.tar.gz

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7000 7500 2222 80 443 1080

ENTRYPOINT ["/entrypoint.sh"]
