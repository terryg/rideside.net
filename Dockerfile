FROM ruby:3.2.3 AS base

WORKDIR /code

COPY . /code

RUN bundle install

FROM base AS client

EXPOSE 4567

CMD ["bundle", "exec", "puma"]
