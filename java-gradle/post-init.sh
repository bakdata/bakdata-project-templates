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
  value="$(grep -e "^$key=" $SECRET_ENV | cut -d "=" -f2 | tr -d '\r')"
  if [[ -z "$value" ]]; then
    if [ -f "$HOME/.gradle/gradle.properties" ]; then
      gradle_key="$(echo "$key" | tr '[:upper:]' '[:lower:]' | sed s/_/.?/g)"
      echo "Cached value for $key not found; trying for ${gradle_key} in gradle.properties"
      value="$(grep -E --ignore-case "^$gradle_key=" "$HOME/.gradle/gradle.properties" | cut -d"=" -f2 | tr -d '\r')"
    fi
    while [[ -z "$value" ]]; do
      read -p "Enter $key (check LastPass): " -s value
    done
    echo "$key=$value" >> $SECRET_ENV
  fi
  travis env set -p "$key" "$value"
done

declare -a required_files=("secring.gpg" "bakdata-bot-deploy-key")
for file in "${required_files[@]}"
do
  while [ ! -f "$SECRETS_CACHE_DIR/$file" ]; do
	read -e -p "Enter location of $file (check LastPass): " location
	cp "${location/#\~/$HOME}" $SECRETS_CACHE_DIR/$file
  done
done

echo "Adding travis secret file containing gpg key and bakdata-bot deploy key"
tar cvf secrets.tar -C $SECRETS_CACHE_DIR secring.gpg bakdata-bot-deploy-key
travis encrypt-file secrets.tar
rm secrets.tar

encryption_key=$(travis env list | grep -E "^encrypted_[0-9a-z]+_key=" | cut -d "=" -f1)
encryption_iv=$(travis env list | grep -E "^encrypted_[0-9a-z]+_iv=" | cut -d "=" -f1)
sed -i 's/encrypted_XXXXXXXXXXXX_key/$encryption_key/g' 's/encrypted_XXXXXXXXXXXX_iv/$encryption_iv/g' .travis.yml