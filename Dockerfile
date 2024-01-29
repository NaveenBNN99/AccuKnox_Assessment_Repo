FROM alpine:latest

WORKDIR /app

COPY wisecow.sh .

RUN chmod +x wisecow.sh

EXPOSE 4499

CMD ["/bin/sh", "./wisecow.sh"]
