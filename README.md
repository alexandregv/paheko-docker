# Garradin dockerized, with built-in Apache2 server.

## Installation

```shell
git clone https://github.com/alexandregv/garradin
cd garradin
```

## Configuration

By default, no configuration is needed. You may open `config.local.php` and add any variable you need, following Garradin docs.  
To use a custom domain (like `garradin.asso.fr`), refer to [Custom Domain](#custom-domain).

## Basic Usage

1. `docker-compose up -d`
2. `docker-compose logs -f` (`Ctrl`+`c` to quit logs)

Garradin will be available at `http://localhost:8080`. You can change the port in `docker-compose.yml`.

## Custom domain

To use a custom domain (like `garradin.asso.fr`), open `config.local.php` and set `WWW_URL` to your full URL, ending with a `/` (e.g `https://garradin.asso.fr/`).  
You may need to restart the container if the permissions of the file changed.
Please note that you likely want to run this behind a reverse-proxy, like Nginx or Traefik. See the next section.

## Reverse proxy (Nginx, Traefik, etc)

Running behind a reverse-proxy allows you to use TLS (HTTPS) and if you are hosting multiple websites you probably already have one.  
You just have to point your proxy at this Garradin instance (`http://localhost:8080`), with a "Proxy Pass" or similar.

Please note that when using your custom domain, even with a reverse-proxy, you MUST follow the instructions given in [Custom Domain](#custom-domain).
