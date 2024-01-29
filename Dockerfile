FROM php:7-fpm
WORKDIR /app
COPY wisecow.sh .
RUN chmod +x wisecow.sh 
ENTRYPOINT ["/bin/sh", "./wisecow.sh"]
