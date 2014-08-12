docker-101
==========

Example Docker project to help you bootstrap your awesome apps.


Hello world
===========

In this example project you can find basic python app that serves some static web pages.

We will use some OS X specific stuff to run Docker, which depends on Linux's containers. And we will try to use Docker as development environment.

Docker setup
------------

1. Install [Boot2Docker](https://github.com/boot2docker/osx-installer/releases) on your machine.
   This will install very simple and easy to use VirtualBox wrapper. The app runs minimal Linux image inside Vagrant, so you'll be running Docker containers inside Linux run on Vagrant which is run with VirtualBox. Easy.
2. Once Boot2Docker is installed you need to initiate its virtual machine. Just execute
```
boot2docker init
```
3. Since Boot2Docker's image is so small it doesn't have VirtualBox guest additions which allow you sharing your directories with host which is very convenient if you like to develop in your container. **So download** [this](http://static.dockerfiles.io/boot2docker-v1.1.2-virtualbox-guest-additions-v4.3.12.iso) image and put it in `~/.boot2docker/boot2docker.iso`. Next, run VirtualBox, select your virtual machine and in *settings -> shared folders* tab **share your home directory** with Boot2Docker virtual machine as **home**. You can find source tutorial [here](https://medium.com/boot2docker-lightweight-linux-for-docker/boot2docker-together-with-virtualbox-guest-additions-da1e3ab2465c). Remember to do this when you are creating Boot2Docker virtual machine from scratch, like after removing it by `boot2docker destroy`.

And you are ready to run Docker on your system via Boot2Docker.

Test it
-------

1. Start Boot2Docker: `boot2docker up`. After a while you should see message like that:
```
To connect the Docker client to the Docker daemon, please set:
    export DOCKER_HOST=tcp://:2375
```
If you want to you can add this environment variable to your .bash_profile.  
2. In project directory create a new file called `Dockerfile`.  
3. In Dockerfile add only two lines:  
```
FROM ubuntu:14.04
RUN ls -all
```
This will choose proper image and run `ls` command.  
4. Build your first Docker container: `docker build .` You should see list of files in root directory in your Linux container.  
5. Weeee!

Demo project
===========

This demo project contains simple app that do several common things for every web site:

1. It compiles CSS styles using SASS.
2. After that it reads Yaml file to Python.
3. It generates HTML site with Jinja2 template and data from Yaml file.
4. And lastly it serves the files using its own Nginx server.

Building container
------------------

To build Docker container with the app just type: `docker build -t docker-101 .`. It will build container according to
`Dockerfile` in this directory and stores it with *tag* `docker-101`. You can find your containers in images list:
 `docker images`.

Running the project
-------------------

After successful build the only thing you have to do to run your server is: `docker run -i -t -p 80:80 docker-101`. `-i` and 
`-t` stands for keeping control over your container in this shell, so you can kill it with *control-c*. `-p 80:80` is
for opening the 80 port on both Boot2Docker virtual machine (first) and our container (second).

Running the project in development mode
---------------------------------------

Since *normal* run of container does not allow us to change files from host machine we have to use some additional magic to use docker as development environment. Remember guest additions and folder sharing? We will gonna use it now.

Following command should do the trick:
```
docker run -i -t -p 80:80 -v <absolute_path_to_project>/:/docker-101 docker-101 /bin/bash
```

 Additional `-v <absolute_path_to_project>:/docker-101` means that we are linking our project directory to `/docker-101` directory in container (we are overriding ADD instruction from Dockerfile).

 Now, all changes in your filesystem will affect container's file system and vice versa. Last `/bin/bash` means that we are overriding CMD instruction with shell so we connect with terminal. After running this command we have access to all stuff in container.

 We can use this mode to let's say run one instance to watch over SASS changes and compile them, and another one to run Nginx.
