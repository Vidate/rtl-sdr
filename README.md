# Alpine linux - setup to run docker

Docker installation process

1. Update packages by running 

    ``apk update``
latest
2. Install docker and docker compose 

    ``apk add docker docker-compose``

3. Set docker to start at booting
    
    ``rc-update add docker boot``

    *to start docker manually run ``service docker start`` /etc/init.d/docker start


4. Add user to docker group

    ``addgroup yourusername docker``

*If needed install git ``apk add git``

# Troubleshooting 
1. Cannot install/update package 
    
    Try to change user to root user or any user which have privilege to run install/update scripts

    e.g. ``su root`` or run command with suffix ``su-exec`` e.g. ``apk update su-exec``
2. How to check current user type? -  ``whoami``
3. Cannot find docker/docker-compose package
```
  docker (no such package):
    required by: world[docker]
  docker-compose (no such package):
    required by: world[docker-compose]
```
Set reposiory for docker/docker-compose
checkout `` /etc/apk/repositories`` for
 ```
http://dl-cdn.alpinelinux.org/alpine/v3.16/main
http://dl-cdn.alpinelinux.org/alpine/v3.16/community
``` 
* I'm using v3.16 alpine version (latest)