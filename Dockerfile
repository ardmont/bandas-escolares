FROM ruby:2.5-slim

LABEL Name=bandas-escolares Version=0.0.1
EXPOSE 3000

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY . /app

RUN apt-get update --fix-missing
RUN apt-get install sqlite3 libsqlite3-dev --assume-yes

RUN apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev --assume-yes
RUN gem install bundler -v 2.0.2

COPY Gemfile Gemfile.lock ./
RUN bundle install

ADD . /app