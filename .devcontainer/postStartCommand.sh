#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# exit on any error, including in pipes
set -e
set -o pipefail

GITHUB_PAGES_VERSIONS=$(curl -sfL https://pages.github.com/versions.json)
# RUBY_VERSION=$(echo "${GITHUB_PAGES_VERSIONS}" | jq -r .ruby)
LATEST_GITHUB_PAGES_VERSION=$(echo "${GITHUB_PAGES_VERSIONS}" | jq -r '.["github-pages"]')
USED_GITHUB_PAGES_VERSION=$(grep --extended-regexp --line-regexp ' +github-pages \([0-9]+\)' Gemfile.lock | sed -e 's/.*(//' -e 's/).*//' )
if [ "${LATEST_GITHUB_PAGES_VERSION}" != "${USED_GITHUB_PAGES_VERSION}" ]
then
    echo Latest github-pages gem version is ${LATEST_GITHUB_PAGES_VERSION}. You have ${USED_GITHUB_PAGES_VERSION}.
    echo Upgrading is recommended by executing \'bundle update github-pages\'
fi