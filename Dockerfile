#
# Middleman Development Image
#
# https://github.com/cbetta/docker-middleman
#

FROM ruby:latest

MAINTAINER Cristiano Betta <cbetta@gmail.com>

RUN apt-get update && apt-get install -y \
  nodejs

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 4567 35729

ENTRYPOINT ["bundle", "exec"]
CMD [ "middleman", "server"]
