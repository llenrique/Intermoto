##################################################################
#### Bootstrap Commands
##################################################################

bootstrap:
	make deps.get
	make ecto.setup
	make npm.install

reset:
	docker-compose run --rm --no-deps phx sh -c "\
		rm -rf /intermoto/src/deps/* \
		&& rm -rf /intermoto/src/_build/dev/* \
		&& rm -rf /intermoto/src/_build/test/* \
		&& rm -rf /intermoto/src/priv/key.key \
		&& rm -rf /intermoto/src/priv/key.crt"
	docker-compose stop
	docker-compose rm -f

##################################################################
#### CI/CD Commands
##################################################################

check.all:
	ENV=test docker-compose run --rm -T phx sh -c "sh /scripts/run-checks.sh"

build.release:
	docker build --build-arg GOOGLE_SECRET_JSON=$GOOGLE_SECRET_JSON --build-arg GH_TOKEN=${GH_TOKEN} --tag resuelve/intermoto:latest .


##################################################################
#### Docker Commands
##################################################################

start:
	docker-compose up -d phx

phx.run:
	docker-compose run --service-ports phx iex --sname resuelve-intermoto -S mix phx.server

phx.iex:
	docker-compose run --rm phx iex -S mix

restart.phx:
	docker-compose restart phx

restart.postgres:
	docker-compose restart postgres

stop.phx:
	docker-compose stop phx

stop.postgres:
	docker-compose stop postgres

logs.phx:
	docker-compose logs -f phx

logs.postgres:
	docker-compose logs -f postgres

shell.phx:
	docker-compose run --rm phx sh

shell.postgres:
	docker-compose run --rm postgres sh

shell.test:
	ENV=test docker-compose run --rm phx sh

##################################################################
#### Development Commands
##################################################################

test:
	ENV=test docker-compose run --rm  phx sh -c "mix test"

test.shell:
	ENV=test docker-compose run --rm phx sh

credo:
	ENV=test docker-compose run --rm --no-deps phx sh -c "mix credo"

coverage:
	ENV=test docker-compose run --rm phx sh -c "mix coveralls.html"

gettext:
	docker-compose run --rm --no-deps phx sh -c "\
		mix gettext.extract \
		&& mix gettext.merge priv/gettext"

routes:
	docker-compose run --rm --no-deps  phx sh -c "mix phx.routes"

deps.get:
	docker-compose run --rm --no-deps phx sh -c "mix deps.get && mix deps.compile"

deps.update:
	docker-compose run --rm --no-deps phx sh -c "\
		mix deps.clean --unlock --unused \
		&& mix deps.get \
		&& mix deps.compile"

ecto.reset:
	docker-compose run --rm phx sh -c "mix ecto.reset"

ecto.reset.test:
	ENV=test docker-compose run --rm phx sh -c "mix ecto.reset"

ecto.setup:
	docker-compose run --rm phx sh -c "mix ecto.setup"

ecto.migrate:
	docker-compose run --rm phx sh -c "mix ecto.migrate"

npm.install:
	docker-compose run --rm -T --no-deps phx sh -c "npm --prefix /intermoto/src/assets install \
	&& cd /intermoto/src/assets \
	&& npm run deploy"

format:
	docker-compose run --rm phx sh -c "mix format"

check.formatter:
	docker-compose run --rm phx sh -c "mix format --check-formatted"
