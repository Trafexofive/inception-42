# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/13 19:00:37 by mlamkadm          #+#    #+#              #
#    Updated: 2025/01/13 19:00:37 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:latest

RUN set -ex \
  && apt-get update \
  && apt-get install -y wget \
  && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp \
  && apt-get install -y php php-cli \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 9000

CMD [ "sleep", "infinity" ]
