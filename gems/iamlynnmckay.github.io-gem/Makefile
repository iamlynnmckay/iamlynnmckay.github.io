# Makefile

.PHONY: all
all: run-example

.PHONY: setup
setup:
	chmod +x ./make/setup.sh && \
	./make/setup.sh

.PHONY: bundle
bundle: setup
	eval "$$(rbenv init -)" && \
	bundle config set --local path 'vendor/bundle' && \
	bundle update && \
	bundle install

.PHONY: build-debug
build-debug: bundle
	bundle exec rake --trace build:debug

.PHONY: bundle
build-release: bundle
	bundle exec rake --trace build:release

.PHONY: bundle
run-example: build-debug
	cd example && \
	make