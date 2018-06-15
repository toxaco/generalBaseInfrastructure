#!/usr/bin/env bash

# force sudo.
sudo printf ""

# Check for docker.
if [ "$(docker version | grep version)" == '' ]; then
	printf "\n\n\n\n Please, first install docker AND docker-compose \n\n";
	printf "For Windows: https://docs.docker.com/docker-for-windows/install/ \n";
	printf "For MAC: https://docs.docker.com/docker-for-mac/install/ \n\n\n";
	exit;
fi

sudo printf "\n\n\n\n\n\n\n\n\n"
sudo printf "Welcome to the setup.\n"
sudo printf "It can take up to 10/30 min. (depending on connection speed). \n\n\n"

read -p "[environment] Remove .git for environment? (y/n) " remove_git
read -p "[environment] Do you wish to start/restart the Environment? (y/n) " start_env

case ${start_env:0:1} in y|Y )
    # Refresh all containers.
    cd ./environment/
    docker-compose stop
    docker-compose rm -f
    docker system prune -a -f --volumes

    # Init Environment.
    docker network create dev > /dev/null
    sudo ifconfig lo0 alias 10.254.254.254
    docker-compose --log-level ERROR up -d --build
    cd ./../
esac

DIRECTORY="./environment/data/mongoSeed/"
if [ -d "$DIRECTORY" ]; then
    read -p '[environment] Do you wish to seed the MongoDB? (y/n) ' seed_mongo
    case ${seed_mongo:0:1} in y|Y )
#        printf "\n\n\n\n Please edit deployDev.sh to have it working. \n\n";

        # Execute MongoDb Seeding
    	docker exec -t mongo mongorestore --host mongo --db DFC_DEV /tmp/mongoSeed/DFC_DEV/ >/dev/null;

        # Execute MongoDb Test User
    	docker exec -t mongo mongoimport --jsonArray --db DFC_DEV --collection artist --file /tmp/mongoSeed/data1.json
    	docker exec -t mongo mongoimport --jsonArray --db DFC_DEV --collection fan --file /tmp/mongoSeed/data2.json

    	# Execute MongoDb dump
        #docker exec -t mongodump --host <host:port> --db <databaseName> --authenticationDatabase <db_name> --username <username> --password <password> --out /var/www/html/deploy/dump
    esac
fi

DIRECTORY="./app1/deploy/"
if [ -d "$DIRECTORY" ]; then
    printf "$DIRECTORY\n"
    read -p '[App] Do you wish to start/restart the app above? (y/n) ' start_app
    case ${start_app:0:1} in y|Y )
        cd "$DIRECTORY"
        printf "Deploying $DIRECTORY \n"
        sudo ./deployDev.sh
        cd ./../../
    esac
fi

DIRECTORY="./app2/deploy/"
if [ -d "$DIRECTORY" ]; then
    printf "$DIRECTORY\n"
    read -p '[App] Do you wish to start/restart the app above? (y/n) ' start_app
    case ${start_app:0:1} in y|Y )
        cd "$DIRECTORY"
        pwd && printf "Deploying $DIRECTORY \n"
        sudo ./deployDev.sh
        cd ./../../
    esac
fi

DIRECTORY="./app3/deploy/"
if [ -d "$DIRECTORY" ]; then
    printf "$DIRECTORY\n"
    read -p '[App] Do you wish to start/restart the app above? (y/n) ' start_app
    case ${start_app:0:1} in y|Y )
        cd "$DIRECTORY"
        pwd && printf "Deploying $DIRECTORY \n"
        sudo ./deployDev.sh
        cd ./../../
    esac
fi

DIRECTORY="./app4/deploy/"
if [ -d "$DIRECTORY" ]; then
    printf "$DIRECTORY\n"
    read -p '[App] Do you wish to start/restart the app above? (y/n) ' start_app
    case ${start_app:0:1} in y|Y )
        cd "$DIRECTORY"
        pwd && printf "Deploying $DIRECTORY \n"
        sudo ./deployDev.sh
        cd ./../../
    esac
fi

case ${remove_git:0:1} in y|Y )
    rm -Rf ./.git
esac

# Clean up environment.
docker system prune -a -f --volumes