FROM alpine:3.17.3
RUN apk --no-cache --update \
    add apache2 curl\
    php81-common \
    php81-xml \
    php81-apache2
#COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY httpd.conf /etc/apache2/httpd.conf
WORKDIR /var/www/localhost/htdocs
RUN ln -sf /proc/self/fd/1 /var/www/logs/access.log && \
    ln -sf /proc/self/fd/1 /var/www/logs/error.log && \
    rm -R /var/www/localhost/htdocs
EXPOSE 80
STOPSIGNAL SIGWINCH

#copy website over - this data will change often
COPY website /var/www/localhost/htdocs
CMD ["httpd", "-D", "FOREGROUND"]