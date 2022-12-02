#!/usr/bin/env bash

( python create_openapi_docs.py)

( npm run generate-fetcher)

CHANGED_UNSTAGED=$(git update-index --refresh)

if [[ $CHANGED_UNSTAGED == *"fetchers.tsx"* ]]
then
  printf "\n"
  printf "ERROR: API fetchers are not up to date with the API. Please run:\n"
  printf "\n"
  # printf "\$ (cd backend && python create_openapi_docs.py)\n\$ (cd frontend && npm run generate-fetcher)\n"
  exit 1
fi