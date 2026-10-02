FROM ruby:4.0.7-alpine AS base

ENV RACK_ENV production

WORKDIR /code

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache alpine-sdk git mariadb-dev ruby-dev

COPY Gemfile* ./

RUN gem install bundler -v 4.0.20

RUN bundle install

COPY . .

FROM base AS client

EXPOSE 4567

CMD ["bundle", "exec", "puma"]
