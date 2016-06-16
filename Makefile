DEV_IMAGE=apache/toree-website
MESSAGE?="Updated Toree site with the latest"
default: run

build: .dev-image

run:
	@docker run -it \
			-p 4000:4000 \
  		-v `pwd`:/src \
  		--workdir /src \
  		$(DEV_IMAGE) bash -c 'bundle exec jekyll build && bundle exec jekyll serve --host 0.0.0.0 --watch'

deploy:
	@docker run -it \
			-p 4000:4000 \
  		-v `pwd`:/src \
  		--workdir /src \
  		$(DEV_IMAGE) bash -c 'bundle exec jekyll build'
	@-(rm -rf toree-site)
	@svn co https://svn.apache.org/repos/asf/incubator/toree toree-site
	@(rm -rf toree-site/site/*)
	@cp -r _site/* toree-site/site
	@(cd toree-site/site && \
		svn add --force * --auto-props --parents --depth infinity -q && \
		svn ci -m '$(MESSAGE)')

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

