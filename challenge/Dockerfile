# Use the PHP 7.0 image with Apache
FROM php:7.0-apache

# Set the working directory
WORKDIR /var/www/html

COPY flag.txt /tmp/

RUN mv /tmp/flag.txt /$(openssl rand -hex 8)_flag.txt

# Update sources to use the Debian archive repositories and remove invalid repositories
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/s/^/#/' /etc/apt/sources.list && \
    sed -i '/stretch-updates/s/^/#/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y mariadb-server mariadb-client git && \
    docker-php-ext-install mysqli && \
    apt-get clean

# Install Smarty using Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer require smarty/smarty

# Copy the source code into the container
COPY src/ .

# Copy entrypoint script to handle custom actions at container start
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Initialize the MariaDB database
COPY init.sql /docker-entrypoint-initdb.d/

# Expose port 80 for web access
EXPOSE 80

# Set the entrypoint script to execute when the container starts
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
