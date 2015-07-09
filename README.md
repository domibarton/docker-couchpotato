## Build

```bash
git clone https://github.com/confirm-it-solutions/docker-couchpotato.git
cd docker-couchpotato
docker build -t <tag> .
```

## Run

```bash
docker run --name couchpotato -v <datadir path>:/datadir -v <media path>:/media
```
