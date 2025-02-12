### Issue with build - ```RUN npm install -g n npm: not found```
vim .config/composer/vendor/overdose/odocker/docker/php/8.2/Dockerfile  (or your version of php)
add npm install:
```dockerfile
RUN apt-get update && apt-get install -y \
  apt-utils \
  gnupg \
  cron \
  git \
  wget \
  gzip \
  libbz2-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmagickwand-dev \
  libmagickcore-dev \
  libmcrypt-dev \
  libpng-dev \
  libsodium-dev \
  libssh2-1-dev \
  libxslt1-dev \
  libzip-dev \
  locales \
  lsof \
  msmtp \
  mailutils \
  default-mysql-client \
  vim \
  zip \
  chromium \
  chromium-sandbox \
  sudo \
  nodejs \
  npm  # <-- Ensure npm is explicitly installed
```