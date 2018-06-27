FROM toxaco/generalbaseinfrastructure:php7

RUN composer require guzzlehttp/guzzle -o

EXPOSE 80

