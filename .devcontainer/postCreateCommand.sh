#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# exit on any error, including in pipes
set -e
set -o pipefail

DESIRED_RUBY_VERSION=$(cat .ruby-version)
SYSTEM_RUBY_VERSION=$(/usr/local/bin/ruby --version | sed -E 's/ruby ([^ ]+).*/\1/')
if [ "${DESIRED_RUBY_VERSION}" == "${SYSTEM_RUBY_VERSION}" ]
then
    printf "\e[31m%s\n%s\e[0m\n" "Initially using system Ruby. This will work. But if rvm changes your config, which happens when changing directories," "then it will break. At that point, you'll want to install ruby using rvm as follows:"
    printf "\e[36m %s\n %s\e[0m\n" "rvm install '${DESIRED_RUBY_VERSION}'" 'bundle install'
else
    echo "System Ruby is ${SYSTEM_RUBY_VERSION}. Installing Ruby ${DESIRED_RUBY_VERSION} using rvm."
    rvm install "${DESIRED_RUBY_VERSION}"
    printf "\e[31m%s\n%s\e[0m\n" "Once your terminal starts, make sure to run the following."
    echo "This isn't done by default because \`rvm use\` can't by called from this script."
    printf "\e[36m %s\n %s\e[0m\n" "rvm use '${DESIRED_RUBY_VERSION}' --default" 'bundle install'
fi
