#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/{.zshrc,.gitignore}
ln -sf $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/.gitignore $HOME/.gitignore_global

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Start Services
brew services start redis mysql postgresql mailhog meilisearch

# Install NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
nvm ls-remote --lts
nvm install --lts
nvm use --lts

# Set default MySQL root password and auth type
#mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

# Install PHP extensions with PECL
pecl install imagick redis swoole

# Install global Composer packages
composer global require laravel/installer laravel/valet laravel/spark-installer friendsofphp/php-cs-fixer beyondcode/expose statamic/cli laravel/forge-cli

# Install global npm packages
npm i -g @adonisjs/cli @bchatard/alfred-jetbrains @quasar/cli @vue/cli anywhere browser-sync cross-env electron-builder eslint-plugin-react eslint-plugin-vue eslint gulp imageoptim-cli laravel-echo-server ngrok nodemon tailwindcss webpack webpack-dev-server

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Make Home directories
mkdir -p $HOME/Projects
mkdir -p $HOME/Goodies

# Symlink the Mackup config file and directory to the home directory
ln -sf $DOTFILES/.mackup.cfg $HOME/.mackup.cfg
ln -sf $DOTFILES/.mackup $HOME/.mackup

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos

# Extra Steps
echo ''
echo Steps to perform after reboot:
echo 1. Install iTerm Shell Integration
echo 2. Install Drivers
echo 3. Install Adobe Apps
echo 4. Install Goodies Apps
echo 5. Restore Documents / Movies from Synology
echo 6. Restore app preferences. Run \'mackup restore\'
echo 7. Restore Goodies. Run \'bpg -c .\'
echo 8. Restore Projects. Run \'bpc -c .\'
echo 9. Restore database. Run \'dbrestore\'
echo 10. Add ssh key to forge / servers
echo ''