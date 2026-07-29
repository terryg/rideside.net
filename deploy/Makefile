RIDESIDE_BRANCH ?= local
ANSIBLE_INVENTORY ?= ansible/inventory
SETUP_STAMP = .setup.stamp

# Ansible lives in the top-level venv; see ../Makefile and ansible.cfg.
VENV ?= _venv
ANSIBLE_GALAXY = ../$(VENV)/bin/ansible-galaxy
ANSIBLE_PLAYBOOK = ../$(VENV)/bin/ansible-playbook

.PHONY: all build check_branch check_inventory clean deploy requirements setup

all: deploy;

check_branch:
ifeq ($(RIDESIDE_BRANCH),)
	@echo ""
	@echo "Must set RIDESIDE_BRANCH. Use \"local\" to deploy current changes,"
	@echo "or use a tag version to deploy a release."
	@echo ""
	@exit 1
endif

check_inventory:
ifeq ($(ANSIBLE_INVENTORY),)
	@echo ""
	@echo "Must set ANSIBLE_INVENTORY. Use \"ansible/inventory\" to use invetory"
  @echo	"from current repository."
	@echo ""
	@exit 1
endif

$(SETUP_STAMP): check_branch check_inventory
	touch $(SETUP_STAMP)

../$(VENV)/bin/activate:
	$(MAKE) -C .. $(VENV)/bin/activate

requirements: ../$(VENV)/bin/activate ansible/requirements.yml
	$(ANSIBLE_GALAXY) collection install -r ansible/requirements.yml

setup: $(SETUP_STAMP) requirements ansible/setup.yml
	$(ANSIBLE_PLAYBOOK) -i ${ANSIBLE_INVENTORY} ansible/setup.yml

build: setup
	./build.sh ${RIDESIDE_BRANCH}

deploy: build ansible/deploy.yml ansible/restart.yml
	$(ANSIBLE_PLAYBOOK) -i ${ANSIBLE_INVENTORY} ansible/deploy.yml
	$(ANSIBLE_PLAYBOOK) -i ${ANSIBLE_INVENTORY} ansible/restart.yml

clean:
	rm $(SETUP_STAMP)
