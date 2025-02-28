FROM ruby:3.2.3-alpine AS base

ENV RACK_ENV production

WORKDIR /code

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache alpine-sdk git mariadb-dev ruby-dev

COPY Gemfile* ./

RUN bundle install

COPY . .

FROM base AS client

EXPOSE 4567

CMD ["bundle", "exec", "puma"]
