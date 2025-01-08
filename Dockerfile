# Use a imagem baseada em Alpine com PHP 8.4
FROM php:8.4-fpm-alpine

# Arguments
ARG user=cristian
ARG uid=1000

# Atualize os pacotes do sistema operacional e instale os pacotes necessários
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    libzip-dev \
    zip \
    unzip \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    icu-dev \
    g++ \
    lame \
    netcat-openbsd \
    tzdata && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd pdo_mysql intl zip && \
    ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

# Instale o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Criação do usuário e permissões
RUN adduser --uid $uid --home /home/$user -s /bin/sh -D $user && \
    mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Alterar para o usuário especificado
USER $user

# Defina o diretório de trabalho
WORKDIR /var/www
