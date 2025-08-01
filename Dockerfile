FROM debian:bullseye AS builder

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libboost-all-dev \
    libssl-dev \
    zlib1g-dev

WORKDIR /app
RUN git clone --recursive https://github.com/purplei2p/i2pd-tools .

RUN make

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    libboost-program-options1.74.0 \
    libssl1.1 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/vain /usr/local/bin/vain

WORKDIR /app

ENTRYPOINT ["/usr/local/bin/vain"]

CMD ["example"]
