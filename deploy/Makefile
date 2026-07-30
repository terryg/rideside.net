RIDESIDE_BRANCH ?= local
ANSIBLE_INVENTORY ?= ansible/inventory
SETUP_STAMP = .setup.stamp
REQUIREMENTS_STAMP = .requirements.stamp

# Ansible lives in the top-level venv; see ../Makefile and ansible.cfg.
VENV ?= _venv
ANSIBLE_GALAXY = ../$(VENV)/bin/ansible-galaxy
ANSIBLE_PLAYBOOK = ../$(VENV)/bin/ansible-playbook

# Keeps the collections path in sync when VENV is overridden. ansible.cfg has
# the same path hard-coded for the default venv, for running ansible by hand.
export ANSIBLE_COLLECTIONS_PATH = ../$(VENV)/collections

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

$(REQUIREMENTS_STAMP): ../$(VENV)/bin/activate ansible/requirements.yml
	$(ANSIBLE_GALAXY) collection install -r ansible/requirements.yml
	touch $(REQUIREMENTS_STAMP)

requirements: $(REQUIREMENTS_STAMP)

setup: $(SETUP_STAMP) $(REQUIREMENTS_STAMP) ansible/setup.yml
	$(ANSIBLE_PLAYBOOK) -i ${ANSIBLE_INVENTORY} ansible/setup.yml

build: setup
	./build.sh ${RIDESIDE_BRANCH}

deploy: build ansible/deploy.yml ansible/restart.yml
	$(ANSIBLE_PLAYBOOK) -i ${ANSIBLE_INVENTORY} ansible/deploy.yml
	$(ANSIBLE_PLAYBOOK) -i ${ANSIBLE_INVENTORY} ansible/restart.yml

clean:
	rm -f $(SETUP_STAMP) $(REQUIREMENTS_STAMP)
