PY_SOURCE_FILES=numbin test
PROJECT=numbin

.PHONY: test doc

build: clean
	@python -m build

clean:
	@-rm -rf build/ dist/ .eggs/ site/ *.egg-info .pytest_cache .mypy_cache
	@-find . -name '*.pyc' -type f -exec rm -rf {} +
	@-find . -name '__pycache__' -exec rm -rf {} +

dev:
	@pip install -e .[dev]

lint:
	@black --check --diff ${PY_SOURCE_FILES}
	@isort --check --diff --project=${PROJECT} ${PY_SOURCE_FILES}

format:
	@autoflake --in-place --recursive ${PY_SOURCE_FILES}
	@isort --project=${PROJECT} ${PY_SOURCE_FILES}
	@black ${PY_SOURCE_FILES}

test:
	@pip install -e .[msgpack]
	@pytest test -vv -s
