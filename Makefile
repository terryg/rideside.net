VENV ?= _venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip
PRE_COMMIT = $(VENV)/bin/pre-commit

.PHONY: setup docker up down logs clean

$(VENV)/bin/activate:
	python3 -m venv $(VENV)
	$(PYTHON) -m pip install --upgrade pip

setup: $(VENV)/bin/activate
	$(PIP) install pre-commit
	$(PRE_COMMIT) install
	git config core.hooksPath hooks

docker:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

clean:
	rm -rf $(VENV)
