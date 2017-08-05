#!/usr/bin/env make

.PHONY: run stop exec log
all: build

build:
	@docker build --tag=wandsas/apt-cacher-ng .

run:
	docker run \
		--name apt-cacher-ng \
		--publish 3142:3142 \
		--volume /srv/docker/apt-cacher-ng:/var/cache/apt-cacher-ng \
		--restart=always \
		-d wandsas/apt-cacher-ng

stop:
	docker stop apt-cacher-ng && \
	docker rm -f apt-cacher-ng

exec:
	docker exec -it apt-cacher-ng bash

log:
	docker exec \
		-it wandsas/apt-cacher-ng tail \
		-f /var/log/apt-cacher-ng/apt-cacher-ng.log
