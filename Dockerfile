FROM php:8.2.6-fpm-bullseye as base
WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	    git \
        unzip \
        gnupg2 \
	    tini \
        supervisor \
        libzip-dev \
        librabbitmq-dev \
        libpq5 \
        libpq-dev \
        libicu-dev \
        libxslt1-dev \
        libyaml-dev \
        && \
    docker-php-ext-configure intl && \
    docker-php-ext-install \
        opcache \
        sockets \
        zip \
        pdo \
        intl \
        xsl \
        pdo_pgsql \
        pcntl \
        && \
    docker-php-source delete && \
    pecl install amqp yaml redis apcu && \
    docker-php-ext-enable amqp yaml redis apcu && \
    apt-get autoremove --purge -y libpq-dev && \
    apt-get purge g++ -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer
COPY scripts scripts
RUN sh scripts/install_supercronic.sh && rm -rvf scripts
