CURRENT_DIRECTORY := $(shell pwd)
include environment

build:
	sed -i.bak 's|^FROM.*|FROM $(DOCKER_OPENJRE)|' Dockerfile && \
	docker build --build-arg SOLR_VERSION=$(SOLR_VERSION) --build-arg SOLR_DOWNLOAD_URL=$(SOLR_DOWNLOAD_URL) -t $(DOCKER_USER)/solr --rm=true . && \
	mv Dockerfile.bak Dockerfile

debug:
	docker run -it -v $(REPO_WORKING_DIR)/config:/usr/share/solr/config -v /tmp/solr:/usr/share/solr/data -p 8983:8983 --entrypoint=sh $(DOCKER_USER)/solr

run:
	docker run -d --name solr -v $(REPO_WORKING_DIR)/config:/usr/share/solr/config -v /tmp/solr:/usr/share/solr/data -p 8983:8983 $(DOCKER_USER)/solr
