# Garradin dockerized, with built-in Apache2 server.

## Usage

### 1. docker-compose

```shell
git clone https://github.com/alexandregv/garradin
cd garradin
docker-compose up -d
docker-compose logs -f
```

### 2. docker only

```shell
docker run -d -t --name garradin -p 8080:80 -v garradin-data:/var/www/garradin/data/ alexandregv/garradin
docker logs -f garradin
```
