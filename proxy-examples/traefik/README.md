# Traefik usage

To use Traefik in front of this Garradin setup, you need to have a running Traefik instance ([Traefik docs](https://doc.traefik.io/traefik/getting-started/quick-start/)).  
Traefik configuration is made by labels on the container, so we will change the `docker-compose.yml` a bit.

Just replace the `docker-compose.yml` file by this new one, and then:
  1. Change the Host to use your own domain
  2. Change the name of the `traefik` network according to your setup (maybe `traefik_default`)
  3. Re-run `docker-compose up -d`

Garradin should be available on your custom domain, with HTTPS if it's configured on your Traefik.  
For more information, please refer to the Traefik documention.
