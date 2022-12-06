#!/usr/bin/env bash
# from https://jaredkhan.com/blog/mypy-pre-commit

mypy --pretty --package package-name --package tests --namespace-packages