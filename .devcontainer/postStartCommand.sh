#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# exit on any error, including in pipes
set -e
set -o pipefail

GITHUB_PAGES_VERSIONS=$(curl -sfL https://pages.github.com/versions.json)
LATEST_GITHUB_PAGES_VERSION=$(echo "${GITHUB_PAGES_VERSIONS}" | jq -r '.["github-pages"]')
DESIRED_GITHUB_PAGES_VERSION=$(grep -m 1 -E '^ +github-pages +\(.+\)$' Gemfile.lock | sed -E 's/.*\(([^)]+).*/\1/' )
if [ "${LATEST_GITHUB_PAGES_VERSION}" != "${DESIRED_GITHUB_PAGES_VERSION}" ]
then
    printf "\e[33m%s\e[0m\n" "WARNING: Latest github-pages gem version is ${LATEST_GITHUB_PAGES_VERSION}. You are using ${DESIRED_GITHUB_PAGES_VERSION}."
    echo Upgrading is recommended by executing \'bundle update github-pages\'
fi