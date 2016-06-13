DEV_IMAGE=apache/toree-website

default: run

build: .dev-image

run:
	@docker run -it \
			-p 4000:4000 \
  		-v `pwd`:/src \
  		--workdir /src \
  		$(DEV_IMAGE) bash -c 'bundle exec jekyll build && bundle exec jekyll serve --host 0.0.0.0 --watch'

.dev-image:
	@-docker rm -f image$@
	@docker run -it \
		-v `pwd`:/src \
		--workdir /src \
		--name image$@ \
		ruby:2.1 bash -c 'bundle install'
	@docker commit image$@ $(DEV_IMAGE)
	@-docker rm -f image$@
	touch $@

