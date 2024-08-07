# Get the base image of Ubuntu version 22.04
FROM ubuntu:22.04

# Update all packages and install utilities nginx, unzip, and curl
RUN apt-get update && \
    apt-get install -y nginx unzip curl

# Configure nginx to run in the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Download and unzip the game into /var/www/html
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master 

RUN cd /var/www/html/ && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip

# Expose the game on port 80
EXPOSE 80

# Start nginx with the specified configuration
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]

# use the command to build image: docker build --no-cache -t 2048-game .
