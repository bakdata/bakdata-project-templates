#!/usr/bin/env bash

# Script to setup a new bakdata project from scratch.

ZIP_NAME="bakdata-project-templates.tar.gz"
DUMMY_DIR=".templates"

# Get existing project templates
echo -e "Downloading templates...\n"
curl -Ls https://github.com/bakdata/bakdata-project-templates/archive/master.zip > $ZIP_NAME

# Extract all templates for now
mkdir -p $DUMMY_DIR && unzip -qq $ZIP_NAME -d $DUMMY_DIR
BASE_DIR=$DUMMY_DIR/bakdata-project-templates-master

echo "Select the project type to create:"
while [ -z "$SELECTED_PROJECT" ]; do
  select SELECTED_PROJECT in $(cd $BASE_DIR && ls -d */);
  do
    break;
  done
done

echo
echo "Setting up $SELECTED_PROJECT ..."

cp -R "$BASE_DIR/$SELECTED_PROJECT/" .

rm -rf $DUMMY_DIR
rm $ZIP_NAME

