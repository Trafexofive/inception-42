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

FROM debian

COPY ./config /etc/nginx/conf.d/

RUN apt update && apt upgrade

RUN apt install -y nginx

EXPOSE 9000

ENTRYPOINT ["tail", "-f", "/bin/bash"]

# CMD [ "./main.sh" ]

