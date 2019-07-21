venv: venv/bin/activate
venv/bin/activate: setup.py
	test -d venv || python3 -m venv venv
	venv/bin/python -m pip install --upgrade pip setuptools wheel
	touch venv/bin/activate

rename: venv/lib/python3.7/site-packages/rope
	git diff --exit-code
	git diff --cached --exit-code
	venv/bin/python rename_module.py
	sed -i 's/'rx'/'rx3'/g' setup.py
	sed -i 's/'rx'/'rx3'/g' tests/test_version.py
	sed -i 's/name = Rx/name = Rx3/g' project.cfg
	git add -A
	git commit -n -m "Apply rx -> rx3 rename"

venv/lib/python3.7/site-packages/rope: venv
	venv/bin/python -m pip install rope

test: venv/bin/pytest
	venv/bin/pytest

venv/bin/pytest: venv
	venv/bin/python -m pip install pytest

clean:
	git clean -xdf

dist: venv project.cfg setup.py README.rst $(shell git ls-files app)
	source venv/bin/activate && \
		python setup.py sdist bdist_wheel

.PHONY: clean deploy
