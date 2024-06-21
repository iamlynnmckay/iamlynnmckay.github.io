#!/bin/bash

set -oue pipefail

# Set DEBUG to true to uninstall and reset all Ruby-related installations and configurations
DEBUG=false

# Define Ruby version
_RUBY_VERSION="3.1.6"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to remove Ruby versions and related configurations
# Will only run if $DEBUG is set to true
_cleanup_ruby_installations() {

    if [ "$DEBUG" = true ]; then

        echo "Cleaning up Ruby installations and configurations..."

        if command_exists rbenv; then
            echo "Uninstalling Ruby versions managed by rbenv..."
            rbenv versions --bare | xargs -n1 rbenv uninstall -f
            rm -rf "$(rbenv root)"
            echo "Uninstalling rbenv versions managed by Homebrew..."
            brew list | egrep '^rbenv@?' | xargs brew uninstall --force --zap || :
        fi

        if command_exists ruby-build; then
            echo "Uninstalling ruby-build versions managed by Homebrew..."
            brew list | egrep '^ruby-build@?' | xargs brew uninstall --force --zap || :
        fi
        
        if command_exists rvm; then
            echo "Uninstalling RVM and Ruby versions managed by RVM..."
            rvm implode
            echo "Uninstall RVM versions managed by Homebrew..."
            brew list | egrep '^rvm@?' | xargs brew uninstall --force --zap || :
        fi
        
        if command_exists brew; then
            echo "Uninstalling Ruby versions managed by Homebrew..."
            brew list | egrep '^ruby@?' | xargs brew uninstall --force --zap || :
        fi
        
        # Delete Ruby configuration files
        echo "Removing Ruby configuration files..."
        rm -f ~/.gemrc ~/.ruby-version ~/.ruby-gemset

        # Delete Ruby directories
        echo "Removing Ruby directories..."
        rm -rf ~/.rvm ~/.rbenv ~/.gem ~/.bundle

        # Remove ruby-related configuration from shell configuration files
        echo ~/.profile ~/.bash_profile ~/.bashrc ~/.zshrc | \
        while read -r file; do
            echo "Removing Ruby-related configuration from $file..."
            if [[ -e $file ]]; then
                sed -I{} 's/eval "\$(rbenv init -)"//g' $file
            fi
        done
        
        # Reset Ruby-related environment variables
        echo "Resetting Ruby-related environment variables..."
        export PATH=$(echo "$PATH" | sed -e 's/:[^:]*rbenv[^:]*//g' -e 's/:[^:]*rvm[^:]*//g')
        echo "PATH=$PATH" >> ~/.bash_profile
        echo "PATH=$PATH" >> ~/.zshrc
        unset RUBY_VERSION
        unset GEM_HOME
        unset GEM_PATH

    fi
}

# Function to set Ruby version
_set_script_ruby_version() {
    RUBY_VERSION=$_RUBY_VERSION
}

# Function to check and install Homebrew
_check_and_install_homebrew() {
    if ! command_exists brew; then
        echo "Homebrew is not installed. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &> /dev/null
    else
        echo "Homebrew is already installed."
    fi
}

# Function to check and install ruby-build
_check_and_install_ruby_build() {
    if ! command_exists ruby-build; then
        echo "ruby-build is not installed. Installing..."
        brew install ruby-build
    else
        echo "ruby-build is already installed."
    fi
}

# Function to check and install rbenv
_check_and_install_rbenv() {
    if ! command_exists rbenv; then
        echo "rbenv is not installed. Installing..."
        brew install rbenv
    else
        echo "rbenv is already installed."
    fi
}

# Function to set up rbenv
_setup_rbenv() {
    local -r files=(~/.bash_profile ~/.zshrc)
    local file
    for file in "${files[@]}"; do
        touch $file
        if ! grep -q 'eval "$(rbenv init -)"' $file; then
            echo "Setting up rbenv in $file..."
            echo 'eval "$(rbenv init -)"' >> $file
            source $file
        else
            echo "rbenv is already set up in $file."
        fi
    done
}

# Function to check and install OpenSSL
_check_and_install_openssl() {
    if ! command_exists openssl; then
        echo "OpenSSL is not installed. Installing..."
        brew install openssl
    else
        echo "OpenSSL is already installed."
    fi
}

# Function to check and install libssl-dev on Ubuntu
_check_and_install_libssl_dev() {
    if [[ "$OSTYPE" == "linux-gnu"* && ! -f /usr/include/openssl/ssl.h ]]; then
        echo "libssl-dev is not installed. Installing..."
        sudo apt-get update && sudo apt-get install -y libssl-dev
    else
        echo "libssl-dev is already installed."
    fi
}

# Function to check and install required build tools
_check_and_install_build_tools() {
    if ! command_exists autoconf || ! command_exists automake || ! command_exists libtool || ! command_exists bison; then
        echo "Installing build tools..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install autoconf automake libtool bison
        else
            sudo apt-get install -y autoconf automake libtool bison
        fi
    else
        echo "Build tools are already installed."
    fi
}

# Function to check and install Ruby
_check_and_install_ruby() {
    if [[ "$(rbenv versions --bare | grep "$RUBY_VERSION")" != "$RUBY_VERSION" ]]; then
        echo "Ruby $RUBY_VERSION is not installed. Installing..."
        RUBY_CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)" rbenv install $RUBY_VERSION
    else
        echo "Ruby $RUBY_VERSION is already installed."
    fi
}

# Function to set the global Ruby version
_set_global_ruby_version() {
    if [[ "$(rbenv global)" != "$RUBY_VERSION" ]]; then
        echo "Setting global Ruby version to $RUBY_VERSION..."
        rbenv global $RUBY_VERSION
    else
        echo "Global Ruby version is already set to $RUBY_VERSION."
    fi
}

# Function to verify Ruby installation
_verify_ruby_installation() {
    if [[ "$(ruby -v | grep "$RUBY_VERSION")" == "" ]]; then
        echo "Ruby version mismatch. Expected $RUBY_VERSION but got:"
        ruby -v
        exit 1
    else
        echo "Ruby is correctly installed."
    fi
}

# Function to check and update RubyGems
_check_and_update_rubygems() {
    if ! gem update --system > /dev/null 2>&1; then
        echo "Updating RubyGems..."
        gem update --system
    else
        echo "RubyGems is already up-to-date."
    fi
}

# Function to check and install Bundler
_check_and_install_bundler() {
    if ! gem list bundler -i; then
        echo "Bundler is not installed. Installing..."
        gem install bundler
    else
        echo "Bundler is already installed."
    fi
}

# Function to verify Bundler installation
_verify_bundler_installation() {
    if ! bundler -v > /dev/null 2>&1; then
        echo "Bundler installation failed. Please check."
        exit 1
    else
        echo "Bundler is correctly installed."
    fi
}

# Function to create or update .ruby-version file
_create_or_update_ruby_version_file() {
    if [[ ! -f .ruby-version || "$(cat .ruby-version)" != "$RUBY_VERSION" ]]; then
        echo "Creating or updating .ruby-version with $RUBY_VERSION..."
        echo "$RUBY_VERSION" > .ruby-version
    else
        echo ".ruby-version is correctly set to $RUBY_VERSION."
    fi
}

# Function to verify Ruby version in project directory
_verify_ruby_version_in_project() {
    if [[ "$(ruby -v | grep -o "$RUBY_VERSION")" == "" ]]; then
        echo "Ruby version mismatch in project directory. Expected $RUBY_VERSION but got:"
        ruby -v
        exit 1
    else
        echo "Ruby version in project directory is correctly set."
    fi
}

# Main function to run all checks and installations
main() {
    _cleanup_ruby_installations
    _set_script_ruby_version
    _check_and_install_homebrew
    _check_and_install_ruby_build
    _check_and_install_rbenv
    _setup_rbenv
    _check_and_install_openssl
    _check_and_install_libssl_dev
    _check_and_install_build_tools
    _check_and_install_ruby
    _set_global_ruby_version
    _verify_ruby_installation
    _check_and_update_rubygems
    _check_and_install_bundler
    _verify_bundler_installation
    _create_or_update_ruby_version_file
    _verify_ruby_version_in_project

    echo "Setup completed successfully."
}

# Run the main function
main
