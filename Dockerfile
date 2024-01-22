FROM alpine:3.9.3

ADD super_netperf /sbin/

RUN apk add build-base && apk add --update curl bash iproute2 iperf3 && \
      curl -L0 https://github.com/ibanmarco/netperf/raw/main/archive/netperf-2.7.0.tar.gz --output netperf-2.7.0.tar.gz && \
      tar -xzf netperf-2.7.0.tar.gz && \
      cd netperf-2.7.0 && ./configure --build=aarch64-unknown-linux --prefix=/usr && make && make install && \
      rm -rf netperf-2.7.0 netperf-2.7.0.tar.gz /usr/share/info/netperf.info && \
      strip -s /usr/bin/netperf /usr/bin/netserver && \
      apk del build-base && rm -rf /var/cache/apk/*

CMD ["/usr/bin/netserver", "-D"]