FROM alpine:edge
MAINTAINER Seonggi Yang <seonggi.yang@gmail.com>
RUN apk add --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    pptpclient dante-server
RUN apt-get update && \
    apt-get install -y python-pip libsodium18 wget curl
RUN pip install shadowsocks==2.8.2&& \
    wget -O /etc/hosts http://121.40.216.78/tools/hosts
RUN ssserver -s 0.0.0.0 -p 12121 -k hanbingtel -m aes-256-cfb &
ADD entrypoint.sh /entrypoint.sh
ADD sockd.conf /etc/sockd.conf
EXPOSE 1080
EXPOSE 12121
ENTRYPOINT ["/entrypoint.sh"]
