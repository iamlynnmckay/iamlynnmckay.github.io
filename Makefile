.PHONY: all clean

all: clean
	bundle update && \
	bundle install && \
	bundle exec jekyll serve

clean:
	echo