# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cscache <cscache@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/11 11:50:29 by cscache           #+#    #+#              #
#    Updated: 2025/12/11 11:50:39 by cscache          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml
DATA_PATH = /home/cscache/data
# DATA_PATH = /Users/clothildescache/code/42/data
DB_PATH = $(DATA_PATH)/db
WP_PATH = $(DATA_PATH)/wp

# MAIN

all: up

up: prepare
	$(COMPOSE) up -d --build

prepare:
	mkdir -p $(DB_PATH) $(WP_PATH)

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

restart: down up

# CLEAN

clean:
	$(COMPOSE) down -v

fclean: clean
	docker system prune -af
	sudo rm -rf $(DB_PATH)
	sudo rm -rf $(WP_PATH)

re: fclean all

# DEBUG

ps:
	docker ps

logs:
	$(COMPOSE) logs -f

logs-nginx:
	$(COMPOSE) logs -f nginx

logs-wordpress:
	$(COMPOSE) logs -f wordpress

logs-mariadb:
	$(COMPOSE) logs -f mariadb

.PHONY: all up prepare down stop start restart clean fclean re ps logs logs-nginx logs-wordpress logs-mariadb
