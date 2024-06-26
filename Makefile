.PHONY: all
all: clean
	bundle config unset path; \
	bundle update --verbose; \
	bundle install --verbose; \
	bundle exec jekyll serve --verbose;

.PHONY: clean
clean:
	rm -rf $$(echo $$(cat .gitignore | grep -v '#'));