_info:=$(shell git config --get remote.origin.url | sed -e 's/.*:\(.*\).git/\1/')
_user:=$(shell echo $(_info) | cut -d \/ -f 1)
_repository:=$(shell echo $(_info) | cut -d \/ -f 2)
_branch:=$(shell git rev-parse --abbrev-ref HEAD)


IMAGE:=$(_repository):$(_branch)

token?=""
org_label?=$(_user)
repo_label?=$(_repository)

.PHONY: d docker
d docker:
	@docker build -t $(IMAGE) .

.PHONY: dr docker-run
dr docker-run: docker
	@docker run -it -e GITHUB_TOKEN="$(token)" $(IMAGE) --yaml $(org_label) $(repo_label)