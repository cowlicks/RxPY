venv: venv/bin/activate
venv/bin/activate: setup.py
	test -d venv || python3 -m venv venv
	venv/bin/python -m pip install --upgrade pip setuptools wheel
	touch venv/bin/activate

rename_module: venv/lib/python3.7/site-packages/rope
	git diff --exit-code
	git diff --cached --exit-code
	venv/bin/python rename_module.py
	git add -A
	git commit -n -m "Apply rx -> rx3 rename"

venv/lib/python3.7/site-packages/rope: venv
	venv/bin/python -m pip install rope

test: venv/bin/pytest
	venv/bin/pytest

venv/bin/pytest: venv
	venv/bin/python -m pip install pytest

clean:
	rm -rf venv/ || true
	rm -rf dist/ || true
	rm -rf build/ || true
	rm -rf *.egg-info/ || true

dist: venv project.cfg setup.py README.rst $(shell git ls-files app)
	source venv/bin/activate && \
		python setup.py sdist bdist_wheel

.PHONY: clean deploy
