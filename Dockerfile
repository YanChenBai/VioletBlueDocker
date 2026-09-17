FROM m.daocloud.io/docker.io/library/php:8.5-fpm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    libcurl4-openssl-dev \
    && docker-php-ext-install \
    pdo_mysql \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && printf '%s\n' \
    'allow_url_fopen=On' \
    'upload_max_filesize=16M' \
    'post_max_size=16M' \
    'memory_limit=256M' \
    > "$PHP_INI_DIR/conf.d/violetblue.ini"

RUN git clone --depth=1 \
    https://github.com/HaruhiYunona/VioletBlue.git \
    /opt/violetblue-src \
    && mkdir -p /opt/violetblue-src/Clover-Lite/cache

WORKDIR /var/www/html

CMD ["php-fpm"]