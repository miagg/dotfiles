# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Add Home bin to path
export PATH="$PATH:/Users/wolfkain/.bin"

# Make sure coreutils are loaded before system commands
# I've disabled this for now because I only use "ls" which is
# referenced in my aliases.zsh file directly.
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"

# Add Database binaries to path
export PATH=/Users/Shared/DBngin/postgresql/15.1/bin:$PATH
export PATH=/Users/Shared/DBngin/mysql/8.0.33/bin:$PATH
export PATH=/Users/Shared/DBngin/redis/7.0.0/bin:$PATH
export MYSQL_UNIX_PORT=/tmp/mysql_3306.sock