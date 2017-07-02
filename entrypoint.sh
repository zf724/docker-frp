#!/bin/sh

if [ ${IS_SERVER} == true ];then
  rm /root/frpc.ini
  /root/frps -c /root/frps.ini
else
  rm /root/frps.ini
  /root/frpc -c /root/frpc.ini
fi
