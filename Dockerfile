# Defining parent image
FROM ubuntu:14.04

# This instruction sets author of the image
MAINTAINER netczuk.tomasz@gmail.com

# Update system
RUN apt-get -y update

# Install Ruby and SASS
RUN apt-get -y install ruby
RUN gem install sass

# Install Python with JINJA templates
RUN apt-get -y install python-dev
RUN apt-get -y install python-pip
RUN pip install jinja2
RUN pip install pyyaml

# Install Ngnix
RUN apt-get -y install nginx

# Copy files from project directory to container (it's needed for production)
ADD . /docker-101

# Change working directory to project's one
WORKDIR /docker-101

# Build app
RUN sass --update .:.
RUN python app.py

# Exposing 80 port
EXPOSE 80

# Run Ngnix and serve the site!
CMD nginx -c /docker-101/nginx.conf