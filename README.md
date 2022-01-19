# Instabug Back End Challenge

[github.com/mostafaElkenany](https://github.com/mostafaElkenany/instabug_challenge)

## Install

### Clone the repository

```shell
git clone https://github.com/mostafaElkenany/instabug_challenge.git
cd instabug_challenge
```
### Set environment variables

1. Create .env file in root directory of the project
2. Copy variables from .env_example into .env file
3. Change the values if you want and to avoid conflicts with port numbers

```shell
cp .env_example .env
```

### Build the images and start the server

Using [Docker Compose](https://docs.docker.com/compose/):

```shell
docker-compose up -d
```
### Initialize the database

```shell
docker-compose run app rails db:create
docker-compose run app rails db:migrate
```
### Health check

Verify all containers are up and running

```shell
docker-compose ps
```
### Check server logs

Verify all containers are up and running

```shell
docker-compose logs -f --tail=100 app
```
