# Middleman site

## Development on local machine

* `bundle install`
* `middleman`
* Visit [127.0.0.1:4567](http://127/0.0.0.1:4567)


## Development on Docker

### Requirement

* Install Docker and Docker Compose
* Copy `.env.example` to `.env`
* Update 'JS_HOST' to reflect `DOCKER_HOST` environment variable if on Mac.

### Running

* Build the docker instance with `docker-compose build`
* Run `docker-compose up`
* Visit [127.0.0.1:4567](http://127/0.0.0.1:4567) to visit site (or `DOCKER_HOST` IP if on Mac)
