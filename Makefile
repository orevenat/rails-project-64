PORT?=3000
RACK_ENV?=development

render-build:
	bundle install
	bundle exec rails assets:precompile
	bundle exec rails assets:clean
	bundle exec rails db:migrate


render-start:
	bundle exec puma -t 5:5 -p ${PORT} -e ${RACK_ENV}

test:
	bin/rake test

setup:
	# cp -n .env.example .env || true
	bin/setup
	bin/rake db:fixtures:load

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop --auto-correct

slim-lint:
	bundle exec slim-lint

console:
	bin/rails c

fixtures-load:
	bin/rake db:fixtures:load

clean:
	bin/rake db:drop

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:migrate
	bin/rails db:fixtures:load

.PHONY: test
