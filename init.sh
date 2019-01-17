#!/usr/bin/env bash

# Script to setup a new bakdata project from scratch.

ZIP_NAME="bakdata-project-templates.zip"
DUMMY_DIR=".templates"
GIT_BRANCH="master"

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
DEFAULT_PROJECT_NAME=$(basename $PWD)
read -p "Enter Project Name (default: $DEFAULT_PROJECT_NAME): " PROJECT_NAME

# We need this awkward-ish solution because `read -i` is not available on OSX
[ -z "$PROJECT_NAME" ] && PROJECT_NAME="$DEFAULT_PROJECT_NAME"

echo "Naming Project: $PROJECT_NAME"
sed -i "" 's/{{project-name}}/'"$PROJECT_NAME"'/g' README.md

# Run any project/language specific install commands
POST_INIT_SCRIPT="post-init.sh"
if [ -f "$POST_INIT_SCRIPT" ]; then
  echo
  echo "Running project specific setup..."
  # Set environment variables needed in subscript
  PROJECT_NAME="$PROJECT_NAME" \
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
