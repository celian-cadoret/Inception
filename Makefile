all : up

up : 
	mkdir -p /home/ccadoret/data/mariadb
	mkdir -p /home/ccadoret/data/wordpress	
	@docker-compose -f ./srcs/docker-compose.yml up -d

re :
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down : 
	@docker-compose -f ./srcs/docker-compose.yml down

stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -f ./srcs/docker-compose.yml start

status : 
	@docker ps