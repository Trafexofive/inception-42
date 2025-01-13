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

FROM debian

RUN apt update && apt upgrade

RUN apt install -y wget wp-cli

RUN apt-get install -y php

# ===== { php plugins
RUN apt-get install php-cli

# ===== { wp plugins

RUN wp core install --url=localhost --title="TEST SITE" --admin_user=admin --admin_password=admin --admin_email=admin@example.com

HEALTHCHECK CMD [ "wp -v" ]

# ===== { wp plugins
# RUN wp plugin install yoast-seo
# RUN wp plugin activate yoast-seo


EXPOSE 9000


CMD [ "./main.sh" ]

