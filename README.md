# Goal | Problem | Requiments

## 1. Easy to use docker-compose scripts to run rlt-sdr on docker (alpine linux).
## 2. Run on Del Wyse 5070 with DVB-T RTL2832U usb -> connected to dipole antena.
## 3. 24/7 rtl_tcp available in local network
# Hardware 
    Dell Wyse 5070
    DVB-T RTL2832U R820T2 plug into dell wyse
    Dipole antena

# Alpine linux - setup to run docker

Docker installation process

1. Update packages

     > apk update

2. Install docker and docker compose 

    > apk add docker docker-compose

3. Set docker to start at booting
    
    > rc-update add docker boot

    *to start docker manually run ``service docker start`` 
    You can also run it from: ``/etc/init.d/docker start``

4. Add user to docker group

    > addgroup yourusername docker

# Build & run docker 
*[Note] I'm build image on server - you can use already builded image.

**[Note] I prefer to use ``docker compose``, but you can use ``docker run``.
1. Build 
    > docker-compose -f docker-compose.yml build --parallel --no-cache

2. Run 
    > docker-compose -f docker-compose.yml up -d

    ```
    - -d, -detach: Detached mode: Run containers in the background.
    - -f,   -file: Path to docker-compose file. 
    ```

    For more information about docker compose, checkout [Docker offical site](https://docs.docker.com/engine/reference/commandline/compose_up/).

# About docker-compose file:
1. ``tty: true`` - keeps docker container running. Equivalent of [``docker run -t``](https://docs.docker.com/engine/reference/run/#foreground)
2. ``privileged: true`` - Give access to all devices form host. You should avoid using this option and use devices option: e.g.

```
     devices: 
        - /dev/ttyUSB0:/dev/ttyUSB0 --USB port with SDR device
```
 Equivalent of [``docker run --privileged``](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities)


# Troubleshooting 
1. Cannot install/update package 
    
    Try to change user to root user or any user which have privilege to run install/update scripts

    e.g. ``su root`` or run command with suffix ``su-exec`` e.g. ``apk update su-exec``

2. How to check current user type?
    > whoami

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

4. Usefull comands

- Stop image by image name
    > docker stop rtl-sdr

- Remove image - I'm using default name

    > docker rmi rtl-sdr_rtl-sdr

- Build

    > docker-compose -f docker-compose.yml build --parallel --no-cache

- Run

    > docker-compose -f docker-compose.yml up -d

- Run command on running container:

    > docker exec rtl-sdr 'Command e.g. ls, rtl_tc, rtl_test'


 [Note]:  I'm using v3.16 alpine version (latest)