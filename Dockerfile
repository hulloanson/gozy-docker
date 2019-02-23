FROM debian:stretch

RUN apt-get update && apt-get --no-install-recommends -y install \
            ca-certificates \
            curl \
            net-tools \
            nginx \
            sudo \
            vim-tiny \
            build-essential \
            pkg-config \
            erlang \
            libicu-dev \
            libmozjs185-dev \
            libcurl4-openssl-dev

COPY scripts /scripts

RUN chmod +x /scripts/*.sh

RUN /scripts/couchdb-install.sh

RUN /scripts/cozy-stack-install.sh

COPY ./start.sh /

COPY ./nginx-config /etc/cozy/

RUN chmod +x /start.sh

EXPOSE 8080 6060 5984 1443

ENTRYPOINT ["/start.sh"]
