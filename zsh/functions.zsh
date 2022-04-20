# Turn off mac after x minutes
turnoff () {
  min=${1:-180}
  timeout=`echo "$min*60" | bc`
  sudo sh -c "echo \"Shuting down in $min minutes...\" && caffeinate -t $timeout && caffeinate -u && shutdown -h now"
}

# Scrape a single webpage with all assets
function scrapeUrl() {
    wget --adjust-extension --convert-links --page-requisites --span-hosts --no-host-directories "$1"
}

# All the dig info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	sleep 2 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}"
	local ip="localhost"
	sleep 2 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}"
}

function db {
    if [ "$1" = "refresh" ]; then
        mysql -uroot -e "drop database $2; create database $2"
    elif [ "$1" = "create" ]; then
        mysql -uroot -e "create database $2"
    elif [ "$1" = "drop" ]; then
        mysql -uroot -e "drop database $2"
    elif [ "$1" = "list" ]; then
        mysql -uroot -e "show databases" | perl -p -e's/\|| *//g'
    fi
}

function dbsync {
    SERVER=$(awk -F "=" '/DB_SYNC_SERVER/{print $2}' .env)
    DB=$(awk -F "=" '/DB_SYNC_DATABASE/{print $2}' .env)
    PASSWORD=$(awk -F "=" '/DB_SYNC_PASSWORD/{print $2}' .env)
    if [[ -z $SERVER || -z $DB || -z $PASSWORD ]]; then
        echo "No configuration was found on .env file"
        return 1
    fi
    echo "Syncing database \"$DB\" to local database..."
    ssh $SERVER "mysqldump -uforge -p$PASSWORD $DB 2>/dev/null | gzip -3 -c" > ~/.dbsync.sql.gz
    gunzip -c ~/.dbsync.sql.gz | mysql -uroot $DB
    rm -rf ~/.dbsync.sql.gz
    php artisan cache:clear
    echo "Done!"
}

function share {
    if [ ! -f "artisan" ]; then
        echo "No laravel application was found"
        return 1
    fi
    DOMAIN=https://${PWD##*/}.test
    ngrok http $DOMAIN --host-header rewrite
}

