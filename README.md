## Build

```bash
git clone https://github.com/dbarton/docker-couchpotato.git
cd docker-couchpotato
docker build -t <tag> .
```

## Run

```bash
docker run --name couchpotato -v <datadir path>:/datadir -v <media path>:/media dbarton/couchpotato
```
