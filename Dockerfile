FROM ruby:2.7.2

RUN apt-get update -qq && \
  apt-get install -y build-essential libpq-dev graphviz

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --version=2.1.4 && \
  bundle config set --local without "$BUNDLE_WITHOUT" && \
  bundle install -j9

COPY . .
