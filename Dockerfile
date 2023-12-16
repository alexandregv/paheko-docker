FROM php:8.1.12-apache

LABEL maintainer="alexandregv <contact@alexandregv.fr>"
LABEL description="Paheko dockerized, with built-in nginx."
LABEL url="https://github.com/alexandregv/garrad2"

# Install php extensions
RUN apt-get -y update \
 && apt-get install -y libicu-dev \
 && docker-php-ext-configure intl \
 && docker-php-ext-install intl \
 && rm -rf /var/lib/apt/lists/*

# Set the paheko version
ENV PAHEKO_VERSION 1.3.4

# Set the timezone
ENV TZ UTC

# Import the entrypoint
COPY docker-entrypoint.sh /usr/local/bin/

# Setup workdir
WORKDIR /var/www/paheko

# Change DocumentRoot, accoring to the docs: https://github.com/docker-library/docs/tree/3c44f101d5db6960873c321500da04beafaceb95/php#changing-documentroot-or-other-apache-configuration
ENV APACHE_DOCUMENT_ROOT /var/www/paheko/www
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Disable Apache2 mod_status (/server-status)
RUN a2dismod status

# Configure timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN printf "[PHP]\ndate.timezone = \"$TZ\"\n" > /usr/local/etc/php/conf.d/tzone.ini

# Download and install paheko
RUN curl -L -O https://fossil.kd2.org/paheko/uv/paheko-$PAHEKO_VERSION.tar.gz \
 && tar xf paheko-$PAHEKO_VERSION.tar.gz -C . --strip-components=1 \
 && rm -r paheko-$PAHEKO_VERSION.tar.gz \
 && chown -R www-data:www-data .

# Download and install paheko plugins
RUN cd ./data/plugins \
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/caisse.tar.gz \
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/dompdf.tar.gz \ 
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/git_documents.tar.gz \
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/helloasso.tar.gz \
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/ouvertures.tar.gz \
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/reservations.tar.gz \
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/stock_velos.tar.gz \
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/taima.tar.gz \
 && curl -L -O https://fossil.kd2.org/paheko-plugins/uv/webstats.tar.gz

# Document on which port Apache is running
EXPOSE 80

# Use a custom entrypoint to configure file permissions and timezone at runtime
ENTRYPOINT ["docker-entrypoint.sh"]

# Configure a healthcheck (check `docker ps` or `docker-compose` ps to see the status)
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/
