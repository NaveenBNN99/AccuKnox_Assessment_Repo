FROM alpine:latest
WORKDIR /app
COPY wisecow.sh .
RUN chmod +x wisecow.sh 
CMD ["./wisecow.sh "]
