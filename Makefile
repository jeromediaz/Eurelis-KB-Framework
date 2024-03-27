#
# gmake
#
SHELL := /bin/bash
CHDIR_SHELL := $(SHELL)

PYTHON := python

#
# Setup
#
init-venv:
	@echo "***** $@"
	${PYTHON} -m venv ./.venv

update-venv: init-venv
	@echo "***** $@"
	@source .venv/bin/activate &&\
	pip install --upgrade pip &&\
	pip install .

install-black: update-venv
	@echo "***** $@"
	@source .venv/bin/activate &&\
	pip install black

install-pylint: update-venv
	@echo "***** $@"
	@source .venv/bin/activate &&\
	pip install pylint

init-project: update-venv install-black install-pylint

#
# Build
#
package-build: update-venv
	@echo "***** $@"
	@source .venv/bin/activate &&\
	pip install --upgrade build &&\
	python -m build

package-fast-rebuild:
	@echo "***** $@"
	@source .venv/bin/activate &&\
	python -m build

package-upload: package-build
	@echo "***** $@"
	@source .venv/bin/activate &&\
	pip install --upgrade twine &&\
	twine upload --repository pypi dist/*
