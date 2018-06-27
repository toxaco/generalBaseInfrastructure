FROM php:7.2.2-fpm

# Exposes port 8080
EXPOSE 8080

# Install PostgreSQL dependencies
RUN apt-get update && rm -rf /var/lib/apt/lists/*