FROM ruby:2.7.2

RUN gem install bundler

WORKDIR /app

RUN bundle config set path vendor/bundle
CMD ["bash"]

