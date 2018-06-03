FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]
