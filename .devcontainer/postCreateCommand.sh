#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# exit on any error, including in pipes
set -e
set -o pipefail

RUBY_VERSION=$(cat docs/.ruby-version)
echo "Installing Ruby ${RUBY_VERSION}"
rvm install "${RUBY_VERSION}"
rvm alias create default "ruby-${RUBY_VERSION}"