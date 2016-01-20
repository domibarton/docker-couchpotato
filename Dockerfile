FROM debian:8
MAINTAINER Dominique Barton

#
# Install all required dependencies.
#

RUN apt-get -q update \
    && apt-get install -qy git python-pip python-dev libz-dev libxml2-dev libxslt1-dev gcc \
    && pip install cheetah lxml pyopenssl \
    && apt-get -y remove python-dev libz-dev libxml2-dev libxslt1-dev gcc \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

#
# Create user and group for CouchPotato.
#

RUN groupadd -r -g 666 couchpotato \
    && useradd -r -u 666 -g 666 -d /couchpotato couchpotato

#
# Get CouchPotato repository.
#

RUN git clone -b master https://github.com/RuudBurger/CouchPotatoServer.git /couchpotato \
    && chown -R couchpotato: /couchpotato

#
# Add CouchPotato init script.
#

ADD couchpotato.sh /couchpotato.sh
RUN chmod 755 /couchpotato.sh

#
# Define container settings.
#

VOLUME ["/datadir", "/download"]

EXPOSE 5050

#
# Start CouchPotato.
#

WORKDIR /couchpotato
CMD ["/couchpotato.sh"]
