FROM debian:8
MAINTAINER Dominique Barton

RUN apt-get -q update \
    && apt-get install -qy git python-pip python-dev libz-dev libxml2-dev libxslt1-dev gcc \
    && pip install cheetah lxml pyopenssl \
    && apt-get -y remove python-dev libz-dev libxml2-dev libxslt1-dev gcc \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN groupadd -r -g 666 couchpotato \
    && useradd -r -u 666 -g 666 -d /couchpotato couchpotato

RUN git clone -b master https://github.com/RuudBurger/CouchPotatoServer.git /couchpotato \
    && chown -R couchpotato: /couchpotato

ADD start.sh /start.sh
RUN chown couchpotato: /start.sh \
    && chmod 755 /start.sh

VOLUME ["/datadir", "/media"]

EXPOSE 8080

USER couchpotato

WORKDIR /couchpotato
CMD ["/start.sh"]
