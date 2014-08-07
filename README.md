docker-101
==========

Example Docker project to help you bootstrap your awesome projects.


Hello world
-----------

In this example project you can find basic python app that serves some static web pages. 

We will use some OS X specific stuff to run Docker, which depends on Linux's containers. And we will try to use Docker 
as development environment.

Docker setup
------------

1. Install [Boot2Docker](https://github.com/boot2docker/osx-installer/releases) on your machine.
   This will install very simple and easy to use VirtualBox wrapper. The app runs minimal Linux image inside Vagrant, 
   so you'll be running Docker containers inside Linux run on Vagrant which is run with VirtualBox. Easy.
2. Since Boot2Docker's image is so small it doesn't have guest VirtualBox guest additions which allow you to share
   directories with host which is very convenient if you like to develop in your container. **So download** 
   [this](http://static.dockerfiles.io/boot2docker-v1.1.2-virtualbox-guest-additions-v4.3.12.iso) image and put it in
   `~/.boot2docker/boot2docker.iso`. Next, run VirtualBox and in *settings -> shared folders* tab **share your home
   directory** with Boot2Docker virtual machine. You can find source tutorial 
   [here](https://medium.com/boot2docker-lightweight-linux-for-docker/boot2docker-together-with-virtualbox-guest-additions-da1e3ab2465c).
   
And you are ready to run Docker on your system via Boot2Docker


Test it
-------

1. Start Boot2Docker: `boot2docker up`. After a while you should see message like that: 
```
To connect the Docker client to the Docker daemon, please set:
    export DOCKER_HOST=tcp://:2375
```
If you want to you can add this environment variable to your path.
2. In project directory create a new file called `Dockerfile`.
3. In Dockerfile add only two lines:
```
FROM ubuntu:14.04
RUN ls -all
```
4. Build your first Docker container: `docker build .` You should see list of files in root directory in your Linux 
   container.
5. Weeee!
 
