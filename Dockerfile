FROM ghcr.io/filecoin-project/lotus-localnet-multiarch:sha-6476830 as lotus

FROM ghcr.io/filecoin-project/boost-localnet-multiarch:sha-46a99a1 as boost

FROM ubuntu:20.04 as builder

RUN apt update && apt install -y binutils

RUN mkdir /usr/local/bin2 
COPY --from=boost /go/src/boost* /usr/local/bin2/
COPY --from=lotus /usr/local/bin/lotus* /usr/local/bin2/

# Strip the debugging from the files to reduce the image size by about half
RUN strip /usr/local/bin2/*

FROM ubuntu:20.04 as runner

ENV BOOST_PATH /var/lib/boost
VOLUME /var/lib/boost
EXPOSE 8080

RUN apt update && apt install -y \
      curl \
      hwloc 

## Fix missing lib libhwloc.so.5
RUN ls -1 /lib/*/libhwloc.so.* | head -n 1 | xargs -n1 -I {} ln -s {} /lib/libhwloc.so.5

WORKDIR /app

COPY --from=builder /usr/local/bin2/* /usr/local/bin/

COPY boost/docker/devnet/boost/entrypoint.sh /app/entrypoint-boost.sh
COPY boost/docker/devnet/booster-http/entrypoint.sh /app/entrypoint-booster-http.sh
COPY boost/docker/devnet/booster-bitswap/entrypoint.sh /app/entrypoint-booster-bitswap.sh
COPY boost/docker/devnet/lotus/entrypoint.sh /app/entrypoint-lotus.sh
COPY boost/docker/devnet/lotus-miner/entrypoint.sh /app/entrypoint-lotus-miner.sh

## Test everything starts
RUN lotus -v && lotus-miner -v && lotus-seed -v && \
      boost -v && booster-http -v && booster-bitswap version
      
ENTRYPOINT ["/bin/bash"]

FROM runner AS filecoin-fvm-localnet-preproofs-2k
RUN lotus fetch-params 2048

FROM runner AS filecoin-fvm-localnet-preproofs-8m
RUN lotus fetch-params 8388608

