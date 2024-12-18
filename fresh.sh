#!/bin/sh

echo "Setting up your Mac..."

# Install Oh My Zsh, FZF, Homebrew and Rosetta
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
export DOTFILES=$HOME/.dotfiles

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
~/.fzf/install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'export PATH="/opt/homebrew/bin:$PATH"' >> $HOME/.zprofile
echo 'eval "$(brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

sudo softwareupdate --install-rosetta

rm -rf $HOME/{.zshrc,.gitignore}
ln -sf $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/.gitignore_global $HOME/.gitignore

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Start Services
brew services start mailpit
brew services start meilisearch

# Install NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
nvm ls-remote --lts
nvm install --lts
nvm use --lts

# Install NvChad (Neovim)
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

# Set default MySQL root password and auth type
#mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

# Install PHP extensions with PECL
#pecl install imagick redis swoole

# Install global npm packages
npm i -g browser-sync ngrok @soketi/soketi @githubnext/github-copilot-cli

# Install Laravel Valet
# $HOME/.composer/vendor/bin/valet install
# $HOME/.composer/vendor/bin/valet trust

# Make Home directories
mkdir -p $HOME/Projects
mkdir -p $HOME/Goodies

# Symlink the Mackup config file and directory to the home directory
# cp $DOTFILES/.mackup.cfg $HOME/.mackup.cfg
# cp $DOTFILES/.mackup/*.cfg $HOME/.mackup

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos

# Extra Steps
echo ''
echo Steps to perform after reboot:
echo 1. Add ssh key to forge / servers
echo 2. Add email signatures
echo 3. Restore Documents / Movies from Synology
echo 4. Restore Goodies. Run \'bpg -c .\'
echo 5. Restore Projects. Run \'bpc -c .\'
echo 6. Restore app preferences. Run \'restore\'
echo 7. Install Drivers
echo 8. Install Adobe Apps
echo 9. Install Goodies Apps
echo 10. Install Xcode
echo 11. Manually configure Dropshare, F-Bar, Fork, IINA, Jdownloader2, Logi Options, Typora
echo 12. Import GPG key for password-store
echo 13. Install composer packages. Run \'composer global require friendsofphp/php-cs-fixer beyondcode/expose statamic/cli laravel/forge-cli\'
echo ''