
FROM debian:bullseye

# Install Nginx and OpenSSL
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Prepare SSL directory and initialize self-signed certificate
RUN mkdir -p /etc/nginx/ssl && \
    \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/cert.key \
    -out /etc/nginx/ssl/cert.crt \
    -subj "/C=MO/ST=Settat/L=Khouribga/O=42/OU=1337/CN=mlamkadm.42.fr"

COPY ./tools/default.conf /etc/nginx/sites-enabled/default

# RUN sleep 5

# Run Daemon-less Nginx
CMD ["nginx", "-g", "daemon off;"]

