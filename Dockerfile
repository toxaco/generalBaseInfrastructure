FROM toxaco/generalbaseinfrastructure:php7
VOLUME /var/app/current/ /var/www/html/
RUN mv -f /var/www/html/deploy/config/nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080