NAME=inception
COMPOSE_PATH=srcs/docker-compose.yml
HOME_PATH=/home/ppiques

$(NAME):
		mkdir -p $(HOME_PATH)/data/mariadb
		mkdir -p $(HOME_PATH)/data/wordpress
		docker compose -p $(NAME) -f $(COMPOSE_PATH) up -d

build:
		docker compose -p $(NAME) -f $(COMPOSE_PATH) build

all: build $(NAME)

logs: 
		docker compose -p $(NAME) -f $(COMPOSE_PATH) logs -f

clean:
		docker compose -p $(NAME) -f $(COMPOSE_PATH) stop

fclean:
		docker compose -p $(NAME) -f $(COMPOSE_PATH) down

rm_images: fclean
		docker rmi inception-mariadb inception-nginx inception-wordpress

rm_volumes:
		docker compose -p $(NAME) -f $(COMPOSE_PATH) down -v

re:	fclean all

.PHONY: all build clean fclean re
