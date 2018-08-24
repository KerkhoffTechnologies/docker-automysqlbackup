SHELL=/bin/bash
buildversion=$(shell cat version)
docker_what=automysqlbackup
dockerhub_where=cpcurtis
gcr_where=us.gcr.io
#gcr_project=

.PHONY: all increment build latest push

all: build

increment:
	echo $$(( $(buildversion) + 1 )) > version

build:
	docker build --force-rm=true -t $(dockerhub_where)/$(docker_what):$(buildversion) .

latest: build
	docker tag $(dockerhub_where)/$(docker_what):$(buildversion) $(dockerhub_where)/$(docker_what):latest

push: latest
    ifdef $(gcr_project)
	    docker tag $(dockerhub_where)/$(docker_what):latest $(gcr_where)/$(gcr_project)/$(docker_what):latest
	    docker push $(gcr_where)/$(gcr_project)/$(docker_what):latest
	endif
	docker push $(dockerhub_where)/$(docker_what):$(buildversion)
	docker push $(dockerhub_where)/$(docker_what):latest
