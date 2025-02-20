RIDESIDE_BRANCH ?= local
ANSIBLE_INVENTORY ?= ansible/inventory

.PHONY: all
all: deploy-all

.PHONY: check_branch
check_branch:
ifeq ($(RIDESIDE_BRANCH),)
	@echo ""
	@echo "Must set RIDESIDE_BRANCH. Use \"local\" to deploy current changes,"
	@echo "or use a tag version to deploy a release."
	@echo ""
	@exit 1
endif

.PHONY: check_inventory
check_inventory:
ifeq ($(ANSIBLE_INVENTORY),)
	@echo ""
	@echo "Must set ANSIBLE_INVENTORY. Use \"ansible/inventory\" to use invetory"
  @echo	"from current repository."
	@echo ""
	@exit 1
endif

.PHONY: deploy-all
deploy-all: deploy-rideside



.PHONY: deploy-all
deploy-all: deploy-kaleidocycle

.PHONY: build
build: check_branch check_inventory
	./build.sh ${RIDESIDE_BRANCH}

.PHONY: deploy
deploy:
	ansible-playbook -i ${ANSIBLE_INVENTORY} ansible/deploy.yml

.PHONY: deploy-kaleidocycle
deploy-kaleidocycle:
	$(MAKE) build
	$(MAKE) deploy
