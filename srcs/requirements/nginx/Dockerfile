
FROM debian:bullseye

RUN apt-get update -y\
    && apt-get upgrade -y \
    && apt-get install -y nginx openssl 

RUN mkdir -p /etc/nginx/ssl \
    && chown -R www-data:www-data /etc/nginx/ \
    && chmod -R 755 /etc/nginx/
    
# Create a certificate with both localhost and mlamkadm.42.fr as subject alternative names
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/cert.key \
    -out /etc/nginx/ssl/cert.crt \
    -subj "/C=MA/ST=settat/L=khouribga/O=1337/OU=1337/CN=localhost" \
    -addext "subjectAltName = DNS:localhost, DNS:mlamkadm.42.fr"

COPY --chown=www-data:www-data ./tools/default.conf /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]
