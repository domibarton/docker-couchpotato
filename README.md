## About

This is a Docker image for [CouchPotato](https://couchpota.to/) - the awesome movie PVR for usenet and torrents.

## Configuration

### Volumes

Mount the following volumes inside your container:

* `<datadir path>:/datadir`
* `<media path>:/media`

### Configuration file

By default the CouchPotato configuration is located on:

```
/datadir/config.ini
```

If you want to change this, set the `CONFIG` environment variable.

### CouchPotato Version

By default the latest CouchPotato version will be used by pointing at the `master` tree of the [CouchPotato git repository](https://github.com/RuudBurger/CouchPotatoServer).
If you want a different version you've set the `VERSION` environment variable to a valid git branch or tag.

_Please note that CouchPotato will automatically be updated when you restart your container._

## Run

### Run via docker CLI

```bash
docker run --name couchpotato -v <datadir path>:/datadir -v <media path>:/media dbarton/couchpotato
```

### Run via docker-compose

```yaml
sabnzbd:
    image: "dbarton/couchpotato"
    container_name: "couchpotato"
    volumes:
        - "<datadir path>:/datadir"
        - "<media path>:/media"
    tty: true
    stdin_open: true
    restart: always
```