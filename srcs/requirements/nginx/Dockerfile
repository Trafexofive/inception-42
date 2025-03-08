
FROM debian:bullseye

# Install Nginx and OpenSSL
RUN apt-get update -y && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Prepare SSL directory and set proper permissions
RUN mkdir -p /etc/nginx/ssl && \
    chown -R www-data:www-data /etc/nginx && \
    chmod -R 755 /etc/nginx

# Generate a self-signed certificate with subject alternative names for localhost and mlamkadm.42.fr
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/cert.key \
    -out /etc/nginx/ssl/cert.crt \
    -subj "/C=MA/ST=Settat/L=Khouribga/O=1337/OU=1337/CN=localhost" \
    -addext "subjectAltName = DNS:localhost, DNS:mlamkadm.42.fr"

# Copy custom Nginx configuration
COPY --chown=www-data:www-data ./tools/default.conf /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]
