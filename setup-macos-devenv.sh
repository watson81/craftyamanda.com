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
RUBY_VERSION=$(cat ${RUBY_VERSION_PATH})

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_missing_packages() {
    local missing_packages=()
    local installed_packages
    installed_packages=$(brew list --quiet --formulae -1)
    for package in "$@" ; do
        if ! echo "${installed_packages}" | grep -q "^${package}$" ; then
            missing_packages+=("$package")
        fi
    done

    if [ "${#missing_packages[@]}" -gt 0 ]; then
        echo "Installing missing packages: ${missing_packages[*]}"
        brew install --formulae "${missing_packages[@]}"
    fi
}

install_ruby() {
    RUBY_INSTALL_FLAGS="--no-reinstall"
    RUBY_INSTALL_DISABLED_WARNINGS="-Wno-deprecated-non-prototype -Wno-unused-but-set-variable"
    RUBY_INSTALL_CFLAGS="${RUBY_INSTALL_DISABLED_WARNINGS}"
    if [[ "${RUBY_VERSION%%.*}" -gt "3" ]] ; then
        ruby-install "${RUBY_INSTALL_FLAGS}" ruby "${RUBY_VERSION}" -- CFLAGS="${RUBY_INSTALL_CFLAGS}"
    else
        # Ruby 3 doesn't support OpenSSL 3 yet. See https://github.com/ruby/openssl/issues/369.
        ruby-install "${RUBY_INSTALL_FLAGS}" ruby "${RUBY_VERSION}" -- --with-openssl-dir="$(brew --prefix openssl@1.1)" CFLAGS="${RUBY_CFLAGS}"
    fi
}

# Check if the system is MacOS Monterey or newer
if [[ $(uname -s) != "Darwin" || $(sw_vers -productVersion | cut -d. -f1) -lt "12" ]]; then
    echo "This script requires macOS Monterey (12.0) or newer."
    exit 1
fi

# Check if Homebrew is installed
if ! command_exists brew &> /dev/null; then
    echo "Homebrew is not installed. Please install it: https://brew.sh/"
    exit 1
fi

# Jekyll requirements
install_missing_packages chruby ruby-install xz
install_ruby

. "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
. "$(brew --prefix)/opt/chruby/share/chruby/auto.sh"

gem install jekyll bundler

# shellcheck disable=SC2016
printf "\e[32;1m%s\e[0m \e[1m%s\e[0m\n" ">>>" "You should add the following to your .bashrc/profile if you haven't already." >&2

cat << 'EOF' >&2
. "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
. "$(brew --prefix)/opt/chruby/share/chruby/auto.sh"
EOF
