FROM debian:8
MAINTAINER confirm IT solutions, dbarton

RUN apt-get -q update \
    && apt-get install -qy git python-cheetah python-openssl \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN groupadd -r -g 666 couchpotato \
    && useradd -r -u 666 -g 666 couchpotato

RUN git clone https://github.com/RuudBurger/CouchPotatoServer.git /couchpotato \
    && chown -R couchpotato: /couchpotato

ADD start.sh /start.sh
RUN chown couchpotato: /start.sh \
    && chmod 755 /start.sh

VOLUME ['/datadir', '/media']

EXPOSE 443

USER couchpotato

WORKDIR /couchpotato
CMD /start.sh
