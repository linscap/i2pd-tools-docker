FROM debian:bullseye AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    libboost-dev \
    libssl-dev \
    zlib1g-dev \
    ca-certificates

WORKDIR /app
RUN git clone --recursive https://github.com/purplei2p/i2pd-tools .

RUN make

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libboost-program-options1.74.0 \
    libboost-filesystem1.74.0 \
    libboost-date-time1.74.0 \
    libboost-chrono1.74.0 \
    libssl1.1 \
    zlib1g \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/vain /usr/local/bin/vain

WORKDIR /app

ENTRYPOINT ["/usr/local/bin/vain"]

CMD ["test"]
