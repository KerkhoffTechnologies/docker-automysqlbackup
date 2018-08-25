SHELL=/bin/bash
BUILDVERSION=$(shell cat version)
DOCKER_WHAT=automysqlbackup
DOCKERHUB_WHERE=cpcurtis
GCR_WHERE=us.gcr.io

.PHONY: all increment build latest push

all: build

increment:
	echo $$(( $(BUILDVERSION) + 1 )) > version

build:
	docker build --force-rm=true -t $(DOCKERHUB_WHERE)/$(DOCKER_WHAT):$(BUILDVERSION) .

latest: build
	docker tag $(DOCKERHUB_WHERE)/$(DOCKER_WHAT):$(BUILDVERSION) $(DOCKERHUB_WHERE)/$(DOCKER_WHAT):latest

gcr:
	# when building for a GCloud project. syntax:
	# make push gcr_project=my_project/folder
	$(info Checking for GCR_PROJECT)
ifneq ($(GCR_PROJECT),)
	docker tag $(DOCKERHUB_WHERE)/$(DOCKER_WHAT) $(GCR_WHERE)/$(GCR_PROJECT)/$(DOCKER_WHAT):$(BUILDVERSION)
	docker tag $(DOCKERHUB_WHERE)/$(DOCKER_WHAT) $(GCR_WHERE)/$(GCR_PROJECT)/$(DOCKER_WHAT):latest
	docker push $(GCR_WHERE)/$(GCR_PROJECT)/$(DOCKER_WHAT):latest
endif

push: latest gcr
	docker push $(DOCKERHUB_WHERE)/$(DOCKER_WHAT):$(BUILDVERSION)
	docker push $(DOCKERHUB_WHERE)/$(DOCKER_WHAT):latest
