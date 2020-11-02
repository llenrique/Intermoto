FROM resuelve/phoenix-alpine:1.5.4-otp22
LABEL maintainer="Enrique Lopez <llenriquelopez@gmail.com>"
ARG GOOGLE_SECRET_JSON
ARG GH_TOKEN
ENV MIX_ENV=prod
COPY ./src /app/src
WORKDIR /app/src
RUN mkdir -p /run/secrets
RUN echo $GOOGLE_SECRET_JSON > /run/secrets/google_credentials
RUN mix deps.get && mix deps.compile
RUN cd assets && npm install && npm run deploy
RUN mix phx.digest && mix distillery.release --no-tar --env=prod

FROM alpine:3.12
RUN apk --no-cache add -U musl musl-dev ncurses-libs libressl3.1-libcrypto bash \
  qt5-qtwebkit qt5-qtbase-x11 qt5-qtsvg qt5-qtdeclarative qt5-qtsvg qt5-qtbase
RUN apk add --update-cache \
  xvfb \
  dbus \
  ttf-freefont \
  fontconfig && \
  apk add --update-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/v3.12/community/ \
  --allow-untrusted \
  wkhtmltopdf && \
  rm -rf /var/cache/apk/* && \
  chmod +x /usr/bin/wkhtmltopdf
COPY --from=0 /app/src/_build/prod/rel /rel

WORKDIR /rel
CMD /rel/intermoto/bin/intermoto foreground
