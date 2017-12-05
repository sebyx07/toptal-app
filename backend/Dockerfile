FROM ruby:2.4

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

RUN mkdir -p /app
WORKDIR /app


RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5