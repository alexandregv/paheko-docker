# Nginx usage

To use Nginx in front of this paheko setup, you need to have a running Nginx instance ([Nginx docs](https://www.nginx.com/resources/wiki/start/)).  
The `paheko.conf` file is a simple nginx configuration file. Follow these instructions:
  1. Place the file in `/etc/nginx/sites-available/paheko.conf`
  2. Enable the site with `ln -s /etc/nginx/sites-available/paheko.conf /etc/nginx/sites-enabled/`
  3. Open the file and change the domain and the SSL certificate path. If you don't want SSL (HTTPS), remove the associated lines

paheko should be available on your custom domain, with HTTPS if you kept it in the config file (and your certificate is valid).  
For more information, please refer to the Nginx documention.
