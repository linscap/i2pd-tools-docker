FROM debian:bullseye-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libboost-all-dev \
    libssl-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/purplei2p/i2pd-tools .

RUN make

ENTRYPOINT ["./vain"]

CMD ["example"]
