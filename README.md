Automated Deployment Scripts (Docker)
=================

Created by Rafael (contact@rafaelphp.com)
------------

 * Clone master branch of this repo:
 ``https://github.com/toxaco/generalBaseInfrastructure.git``
 * Clone your applications into app1, app2, etc. (use dot at the end of "git clone"). Example: 
   - ``cd app1 && git clone https://github.com/toxaco/generalBaseInfrastructure.git .``
 * Place your mongoDb migrations into the "./environment/data/mongoSeed/<DB_NAME>/" folder and adjust deployDev.sh 
 * Execute the deployDev.sh.
 * Once it's finished (may take some time for the first time), open this link and enter your desired password:
    - [Admin Panel](http://localhost:9900)
 * That's it, you are all setup.
 

Details
---------

 * Mongo is set to not have pass for dev.
 * Use the admin panel to manage the containers.
 
 
 Docker Images:
 ---------
 
 You can use these docker images to build your docker-compose applications:
 
 * toxaco/generalbaseinfrastructure:php7
 * toxaco/generalbaseinfrastructure:php5  
 
 Go to [Docker Hub](https://hub.docker.com/r/toxaco/generalbaseinfrastructure/tags/) for more details.