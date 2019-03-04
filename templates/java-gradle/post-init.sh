#!/usr/bin/env bash
gradle wrapper
mkdir -p src/main/java src/main/resources src/test/java src/test/resources

# Set project name in Gradle
echo "rootProject.name = '$REPO_NAME'" >> settings.gradle
