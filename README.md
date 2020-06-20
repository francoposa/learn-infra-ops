# learn-ci-cd

Installing Docker on Ubuntu: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

Alpine Docker images: https://hub.docker.com/_/alpine/

pull docker postgres image, run exec -it bash

su - post in order to be able to run initdb command
initdb -D /var/lib/postgresql/data/  -U postgres
pg_ctl -D /var/lib/postgresql/data/ start
