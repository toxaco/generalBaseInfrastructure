#!/usr/bin/env bash

# Check for docker.
if [ "$(docker version | grep version)" == '' ]; then
	printf "\n\n\n\n Please, first install docker AND docker-compose \n\n";
	printf "For Windows: https://docs.docker.com/docker-for-windows/install/ \n";
	printf "For MAC: https://docs.docker.com/docker-for-mac/install/ \n\n\n";
	exit;
fi

sudo echo "Welcome to the setup. (Max exec time is ~10min)"

read -p '[environment] Do you wish to start/restart the Environment? (y/n) ' start_env
read -p '[environment] Do you wish to seed the MongoDB? (y/n) ' seed_mongo
read -p '[App] Do you wish to start/restart app1? (y/n) ' start_app1
read -p '[App] Do you wish to start/restart app2? (y/n) ' start_app2

case ${start_env:0:1} in y|Y )
    # Allow XDebuger to work properly.
    docker network create dev >/dev/null && sudo ifconfig lo0 alias 10.254.254.254;

    # Init Environment.
    cd ./environment/ && docker-compose stop && docker-compose rm -f >/dev/null && docker-compose --log-level ERROR up -d --build >/dev/null 
    cd ./../
esac

case ${seed_mongo:0:1} in y|Y )
    printf "\n\n\n\n Test mongo has been seeded! \n\n";
	# Execute MongoDb Seeding
#	docker exec -t mongo mongorestore --host mongo --db <db_name> /tmp/mongoSeed/<db_name>/ >/dev/null;

	# Execute MongoDb Test User
#	docker exec -t mongo mongoimport --jsonArray --db <db_name> --collection artist --file /tmp/mongoSeed/data1.json
#	docker exec -t mongo mongoimport --jsonArray --db <db_name> --collection fan --file /tmp/mongoSeed/data2.json
	#docker exec -t mongodump --host <host:port> --db <databaseName> --authenticationDatabase <db_name> --username <username> --password <password> --out /var/www/html/deploy/dump
esac

# Deploy dev.start_app1.com
case ${start_app1:0:1} in y|Y )
    cd ./start_app1/deploy/ && ./deployDev.sh && cd ./../../
esac

# Deploy dev.start_app2.com
case ${start_app2:0:1} in y|Y )
    cd ./start_app2/deploy/ && ./deployDev.sh && cd ./../../
esac

# Clean up environment.
docker system prune -a -f --volumes