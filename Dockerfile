FROM ruby:2.5.0
WORKDIR /healthy_rack
COPY . ./
RUN bundle install
