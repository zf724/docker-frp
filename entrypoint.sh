#!/bin/sh

if [ ${IS_SERVER} == true ];then
  mv frp_${VERSION}_linux_amd64/frps .
  rm -rf frpc.ini frp_${VERSION}_linux_amd64
  ./frps -c frps.ini
else
  mv frp_${VERSION}_linux_amd64/frpc .
  rm -rf frps.ini frp_${VERSION}_linux_amd64
  ./frpc -c frpc.ini
fi
