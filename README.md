Automated Deployment Scripts (Docker)
=================

Created by Rafael (contact@rafaelphp.com)
------------

 * Run the this command (from your desired directory):
 ``git clone https://github.com/toxaco/generalBaseInfrastructure.git . && rm ./app1/.gitkeep && rm ./app2/.gitkeep && rm ./app3/.gitkeep && rm ./app4/.gitkeep && rm -Rf ./.git rm ./.gitignore``
 * Clone your applications into app1, app2, etc. (use dot at the end of "git clone"). Example: 
   - ``cd app1 && git clone https://github.com/toxaco/generalBaseInfrastructure.git .``
 * Place your mongoDb migrations into the "./environment/data/mongoSeed/<DB_NAME>/" folder and adjust deployDev.sh 
 * Execute this command:
 ``sudo ./deployDev.sh``
 * Once it's finished (may take some time for the first time):
    - Open this [Admin Panel](http://localhost:9900)
    - Enter your desired password.
    - Select "Manage local instances" (or something like this).
        - All the necessary settings have been done for it.
 * That's it, you are all setup.
 

Details
---------

 * Mongo is set to not have pass for dev.
 * Use the admin panel to manage the containers.
 
 
 Docker Images:pa
 ---------
 
 You can use these docker images to build your docker-compose applications:
 
 * toxaco/generalbaseinfrastructure:php7
 * toxaco/generalbaseinfrastructure:php5  
 
 Go to [Docker Hub](https://hub.docker.com/r/toxaco/generalbaseinfrastructure/tags/) for more details.