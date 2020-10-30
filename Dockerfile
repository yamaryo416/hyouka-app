FROM ruby:latest

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 	 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
   && apt-get update \
   && apt-get install -y \
    build-essential \
		libpq-dev \
		nodejs \
		postgresql-client \
    yarn
WORKDIR /hyouka-app
COPY Gemfile Gemfile.lock /hyouka-app/
RUN bundle install
