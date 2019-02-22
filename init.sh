#!/usr/bin/env bash

# Script to setup a new bakdata project from scratch.

# Check prerequisites
command -v travis >/dev/null 2>&1 || { echo >&2 "Command travis required but not installed."; exit 1; }

ZIP_NAME="bakdata-project-templates.zip"
DUMMY_DIR=".templates"
GIT_BRANCH="master"
SECRETS_CACHE_DIR="$HOME/.bakdata"

# Get existing project templates
echo -e "Downloading templates...\n"
curl -H 'Cache-Control: no-cache' -Ls "https://github.com/bakdata/bakdata-project-templates/archive/$GIT_BRANCH.zip" > $ZIP_NAME

# Extract all templates for now
mkdir -p $DUMMY_DIR && unzip -qq $ZIP_NAME -d $DUMMY_DIR
BASE_DIR="$DUMMY_DIR/bakdata-project-templates-$GIT_BRANCH"

echo "Select the project type to create:"
while [ -z "$SELECTED_PROJECT" ]; do
  select SELECTED_PROJECT in $(cd $BASE_DIR && ls -d */);
  do
    break;
  done
done

echo
echo "Setting up $SELECTED_PROJECT ..."

# Copy templates
cp -R "$BASE_DIR/$SELECTED_PROJECT/" .

# Do some project name related things
REPO_NAME=$(basename $PWD)
read -p "Enter Pretty Project Name (default: $REPO_NAME): " PROJECT_NAME

# We need this awkward-ish solution because `read -i` is not available on OSX
[ -z "$PROJECT_NAME" ] && PROJECT_NAME="$REPO_NAME"

echo "Naming Project: $PROJECT_NAME"
sed -i "" 's/{{project-name}}/'"$PROJECT_NAME"'/g' README.md
sed -i "" 's/{{repo-name}}/'"$REPO_NAME"'/g' README.md

# Run any project/language specific install commands
POST_INIT_SCRIPT="post-init.sh"
mkdir -p $SECRETS_CACHE_DIR
if [ -f "$POST_INIT_SCRIPT" ]; then
  echo
  echo "Running project specific setup..."
  # Set environment variables needed in subscript
  REPO_NAME="$REPO_NAME" PROJECT_NAME="$PROJECT_NAME" SECRETS_CACHE_DIR="$SECRETS_CACHE_DIR" \
    sh "$POST_INIT_SCRIPT"

  rm "$POST_INIT_SCRIPT"
fi

# Clean up
rm -rf $DUMMY_DIR
rm $ZIP_NAME

# Add all files to git initially
if [ -d ".git" ]; then
  git add -A
fi

