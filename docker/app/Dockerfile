FROM ruby:2.5.3-alpine
WORKDIR /usr/src/app
RUN apk --no-cache add build-base postgresql-dev
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .
CMD ["irb"]
