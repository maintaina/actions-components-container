FROM docker.io/opensuse/tumbleweed:latest

# set working directory for all subsequent steps (and images derived from this one)
WORKDIR /srv/www/horde-uut

# installs required packages git, composer, unzip and php extensions
# then cleans up zypper cache
# then creates the target directory for horde and clones the deployment

RUN --mount=type=secret,id=composerauth,dst=/COMPOSER_AUTH export COMPOSER_AUTH=$(cat /COMPOSER_AUTH) \
    && zypper --non-interactive install --no-recommends --no-confirm \
    openssh-clients \
    git-core \
    gzip \
    php-composer \
    php7 \
    php7-bcmath \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-gd \
    php7-gettext \
    php7-iconv \
    php7-imagick \
    php7-json \
    php7-ldap \
    php7-mbstring \
    php7-mysql \
    php7-opcache \
    php7-openssl \
    php7-pcntl \
    php7-pdo \
    php7-pear \
    php7-phar \
    php7-posix \
    php7-redis \
    php7-soap \
    php7-sockets \
    php7-sqlite \
    php7-tokenizer \
    php7-xmlrpc \
    php7-xmlwriter \
    tar \
    unzip \
    gettext-tools \
    && echo $COMPOSER_AUTH >> /srv/secret \
    ## This step is needed because the docker base image's locale is crippled to save space. Horde NLS needs them
    && zypper --non-interactive install --no-recommends --no-confirm -f glibc-locale glibc-locale-base \
    && mkdir -p /root/.ssh/ && ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts \
    && zypper clean -a \
    && mkdir -p /srv/www/horde-components \
    && mkdir -p /srv/www/horde-uut \
    && mkdir -p /srv/original_config/apps \
    && git clone --depth 5 https://github.com/maintaina-com/horde-deployment.git /srv/www/horde-components \
    && cd /srv/www/horde-components \
    && composer require horde/components \
    && composer install -n ; composer clear-cache ; rm -rf /root/.composer/cache

COPY ./bin/* /usr/local/bin/
RUN chmod -R +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
