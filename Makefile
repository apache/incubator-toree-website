default: build

dep:
	bundle install

build: dep
	bundle exec jekyll build

run:
	bundle exec jekyll serve

