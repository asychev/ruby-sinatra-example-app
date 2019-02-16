FROM ruby:2.3.8-alpine3.8 as builder

RUN apk add --no-cache build-base

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install --deployment --without development test -j4 --retry 3

COPY . /app/

FROM ruby:2.3.8-alpine3.8

RUN mkdir -p /app; addgroup -S app -g 1000 && adduser -S -G app -g 1000 app

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=app:app /app/ /app/

USER app

WORKDIR /app

EXPOSE 3000

CMD ["bundle", "exec", "rackup", "-E", "deployment", "-p", "3000"]
