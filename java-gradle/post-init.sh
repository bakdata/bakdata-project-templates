#!/usr/bin/env bash
gradle wrapper
mkdir -p src/main/java src/main/resources src/test/java src/test/resources

# Set project name in Gradle
echo "rootProject.name = '$PROJECT_NAME'" >> settings.gradle

###
# Secret management with cache
###
SECRET_ENV="$SECRETS_CACHE_DIR/env"
touch "$SECRET_ENV"
declare -a required_variables=("OSSRH_USERNAME" "OSSRH_PASSWORD" "SIGNING_KEY_ID" "SIGNING_PASSWORD" "SONAR_TOKEN")
for key in "${required_variables[@]}"
do
  value="$(grep -e "^$key=" $SECRET_ENV | cut -d "=" -f2- | tr -d '\r')"
  if [[ -z "$value" ]]; then
    if [ -f "$HOME/.gradle/gradle.properties" ]; then
      gradle_key="$(echo "$key" | tr '[:upper:]' '[:lower:]' | sed s/_/.?/g)"
      echo "Cached value for $key not found; trying for ${gradle_key} in gradle.properties"
      value="$(grep -E --ignore-case "^$gradle_key=" "$HOME/.gradle/gradle.properties" | cut -d"=" -f2- | tr -d '\r')"
    fi
    while [[ -z "$value" ]]; do
      read -p "Enter $key (check LastPass): " -s value
    done
    echo "$key=$value" >> $SECRET_ENV
  fi
  travis env set -p "$key" "$value"
done

declare -a required_files=("SIGNING_SECRET_KEY_RING" "GITHUB_DEPLOY_SSH_KEY")
for key in "${required_files[@]}"
do
  value="$(grep -e "^$key=" $SECRET_ENV | cut -d "=" -f2- | tr -d '\r')"
  if [[ -z "$value" ]]; then
    while [[ -z "$value" ]]; do
      read -p "Enter $key (base64 encoded\!, check LastPass): " -s value
    done
    echo "$key=$value" >> $SECRET_ENV
  fi
  travis env set -p "$key" "$value"
done
