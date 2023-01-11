#!/usr/bin/env bash
# from https://jaredkhan.com/blog/mypy-pre-commit

mypy --pretty {package_name} tests
