# Stage 1: Build dependencies
FROM php:8.0-cli AS builder

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install zip pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy only the necessary files for composer dependencies
COPY composer.json composer.lock /var/www/html/
RUN composer install --no-scripts --no-autoloader

# Stage 2: Build the final image
FROM php:8.0-cli

# Set working directory
WORKDIR /var/www/html

# Copy only necessary files from the builder stage
COPY --from=builder /var/www/html/vendor /var/www/html/vendor
COPY --from=builder /usr/local/bin/composer /usr/local/bin/composer

# Copy the rest of the application files
COPY . /var/www/html/

# Generate autoload files
RUN composer dump-autoload --optimize

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port
EXPOSE 8080

# Start Laravel application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]