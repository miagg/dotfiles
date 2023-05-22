# Shortcuts
alias h="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias clone='mirror -c'
alias mp='mirror -l ~/Projects/'
alias bp='mirror -l ~/Projects/ -r /volume1/Common/Projects/ -h synology'
alias bpc='mirror -l ~/Projects/ -r /volume1/Common/Projects/ -h synology -x -a "--exclude \"#Archive/\""' # Copy only
alias bpg='mirror -l ~/Goodies/ -r /volume1/Common/Mac/Goodies/ -h synology'
alias dwsync='mirror -l ~/Projects/Sites/doctorweb.gr/doctorweb/storage/app/public/ -r www.doctorweb.gr/storage/app/public/ -h apptime'
alias dbbackup='mysqldump -u root --all-databases > $HOME/Goodies/Tools/Backup/localdb.sql && bpg Tools'
alias dbrestore='bpg -c Tools && mysql -u root < $HOME/Goodies/Tools/Backup/localdb.sql'
alias cleandots="find . -name .DS_Store -type f -delete ; find . -type d | xargs dot_clean -m"
alias cleardns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]" |pbcopy'
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zshrc"
alias ttfb="curl -s -w '\nLookup time:\t\t%{time_namelookup}\nConnect time:\t\t%{time_connect}\nSSL handshake time:\t%{time_appconnect}\nPre-Transfer time:\t%{time_pretransfer}\nRedirect time:\t\t%{time_redirect}\nTime to first byte:\t%{time_starttransfer}\n\nTotal time:\t\t%{time_total}\n' -o /dev/null"
alias ls="$(brew --prefix coreutils)/libexec/gnubin/ls -N --color --group-directories-first"
alias ll="$(brew --prefix coreutils)/libexec/gnubin/ls -AhlFNo --color --group-directories-first"
alias lscon="lsof -i +c 40 -P | grep ESTABLISHED | awk -v OFS='\t' '{print \$1, \$8, \$9}'"
alias lsports="lsof -i +c 40 -P | grep LISTEN | awk -v OFS='\t' '{print \$1, \$8, \$9}'"
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias compile="commit 'compile'"
alias version="commit 'version'"
alias nodeinspect="ssh -nNTL 9229:localhost:9229"
alias pt="papertrail"
alias vim="nvim"

# Manage servers
alias syn="ssh syn"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"

# Laravel
alias a="php artisan"
alias art="php artisan"
alias fresh="php artisan migrate:fresh --seed"
alias seed="php artisan db:seed"
alias ide='art ide-helper:generate && art ide-helper:eloquent && art ide-helper:models -N && art ide-helper:meta'
alias lint='composer lint'
alias cfresh="rm -rf vendor/ composer.lock && composer i"
alias nfresh="rm -rf node_modules/ && npm install"
alias bs='browser-sync start --files "**/*.php, **/*.html, **/*.css, **/*.js" --proxy'
alias rh='npm run hot'
alias rd='npm run dev'
alias rp='npm run prod'
alias rt='npm run test'
alias rw='npm run watch'
alias rb='npm run build'
alias rst='npm run start'
alias rbs='npm run bs'
alias rwp='npm run watch-poll'
alias php80="$HOMEBREW_PREFIX/opt/php@8.0/bin/php"

# Homestead
alias vm='pushd ~/Homestead && vagrant ssh && popd'
alias vmup='pushd ~/Homestead && vagrant up && popd'
alias vmdown='pushd ~/Homestead && vagrant halt && popd'
alias vmdestroy='pushd ~/Homestead && vagrant destroy --force && popd'
alias vmreload='pushd ~/Homestead && vagrant reload --provision && popd'
alias vmhosts='code /etc/hosts'
alias vmedit='code ~/Homestead/Homestead.yaml'

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color --graph --all"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"

# WOL
alias wakepost1="ssh -p30022 admin@client.matchframe.gr 'sh /share/CommonSpace/BACKUP/QNAP/wakepost1'"
alias wakepost2="ssh -p30022 admin@client.matchframe.gr 'sh /share/CommonSpace/BACKUP/QNAP/wakepost2'"
alias wakepost3="ssh -p30022 admin@client.matchframe.gr 'sh /share/CommonSpace/BACKUP/QNAP/wakepost3'"
alias wakemac="ssh synology '/usr/local/sbin/wake'"