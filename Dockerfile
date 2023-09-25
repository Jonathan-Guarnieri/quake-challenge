FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

RUN chmod +x /app/bin/init-db.sh
COPY bin/init-db.sh /docker-entrypoint-initdb.d/

CMD ["ruby", "app.rb"]
