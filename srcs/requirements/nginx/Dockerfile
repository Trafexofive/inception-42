# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/09 21:51:53 by mlamkadm          #+#    #+#              #
#    Updated: 2025/01/09 21:51:53 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster



RUN apt-get update
RUN apt-get install -y nginx


COPY . /etc/nginx/conf.d/

EXPOSE 9000

# ENTRYPOINT ["nginx", "-g", "daemon off;"]

ENTRYPOINT ["tail", "-f", "/bin/bash"]

# CMD [ "./main.sh" ]

