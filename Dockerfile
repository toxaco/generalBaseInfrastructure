FROM toxaco/generalbaseinfrastructure:php7

RUN composer require guzzlehttp/guzzle -o

EXPOSE 80
CMD ["/usr/bin/bash”]

