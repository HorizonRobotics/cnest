# How to run the unit test

Since `ctest` is a [pybind11](https://pybind11.readthedocs.io/en/stable/) based python library, you will need to compile it first before being able to run the unit tests here.

## Option 1: Install cnest locally

Assuming you are in the repo's root directory, you could install `cnest` locally with

```bash
$ pip install .
```

And then run the test with

```bash
$ python -m unittest discover
```

## Option 2 (Recommended): Test in a nix shell

The package `cnest` comes with `flake.nix` so that you can activate the test environment to run the unit tests. This is much cleaner as it will not pollute your local or global development environment.

To activate the test environment, run

```bash
$ nix develop .#testShell
```

Once you are in the test environment, run

```bash
$ pytest -v
```

to run all the tests.
