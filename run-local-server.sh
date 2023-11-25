#!/usr/bin/env bash

# exit on any error, including in pipes
set -e
set -o pipefail

. dev.env

# Make sure we're running in the expected directory
RUBY_VERSION_PATH="${JEKYLL_SRC_DIR}/.ruby-version"
if [ ! -r "${RUBY_VERSION_PATH}" ] ; then
    echo "This script should be executed in the project root directory."
    exit 1
fi

cd "${JEKYLL_SRC_DIR}"

bundle exec jekyll serve
