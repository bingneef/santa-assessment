#!/bin/sh
# Exit on fail
set -e

bundle_install() {
  apt-get update -qq
  apt-get install -y make gcc g++
  # Install gems
  bundle install --jobs 3 --retry 3 --binstubs="$BUNDLE_BIN"
  # Cleanup the build-deps to save space
  apt-get purge -y --auto-remove make gcc g++
}

# Ensure all gems are installed.
bundle check || bundle_install

# Ensure all packages are installed.
bin/yarn check --integrity || bin/yarn install

eval `ssh-agent -s`

# Finally call command issued to the docker service
exec "$@"
