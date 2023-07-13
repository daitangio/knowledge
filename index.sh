#!/bin/bash

set -eo pipefail
DB=${LEARN_DB:-~/.learndb-v1.sqlite3}
LEARN_HOME=$(dirname $0)
set -u
export PATH=$LEARN_HOME/bin:$PATH


initDB() {
    dbfile="$1"
    echo "Initializing $dbfile"
    sqlite3 $dbfile -batch .quit -init $LEARN_HOME/ddl/01-setup.sql
}

importFiles(){
        for elem in $* ; do
            if test -d $elem; then
                echo "Processing directory $elem..."
                find $elem -type f -print0 | xargs -0  --max-args=50  $0 import 
            else 
                sqlite3 $DB -batch  "INSERT INTO FILE_TO_LOAD VALUES ( '$(realpath $elem)' )"
            fi
        done
        sqlite3 $DB -batch .quit -init $LEARN_HOME/ddl/50-import.sql
}

pumpUrl() {
    content="$1"
    url="$2"
    sqlite3 $DB -batch  "INSERT INTO URL_TO_LOAD(url,content)  VALUES ( '$2', '$(realpath $content)' )"

}

importURLs() {
    tempdir=/tmp/$$.knowledge/
    mkdir -p "$tempdir"
    for url in $*; do
        tmp=$(mktemp --suffix=.html --tmpdir=$tempdir)
        echo $tmp
        # Ignore unrecoverable urls
        (curl -L -o $tmp "$url" && pumpUrl $tmp "$url" )  &
    done
    wait
    sqlite3 $DB -batch .quit -init $LEARN_HOME/ddl/50-import.sql
    rm -r $tempdir
}
# Main
test -f "$DB" || initDB "$DB"

set +u
case "$1" in 
    import|file)
        shift 1
        importFiles "$*"
        ;;
    search)
        shift 1
        # rank is like bm25: smaller is better 
        SEARCH_STRING="select  (path ||'(' || rank || ')') as path_ranked, snippet(doc,1, '**','**','..',8) as snippet from doc where body match '$*' order by rank  limit 7"
        echo $SEARCH_STRING
        set -x
        set +e
        sqlite3 $DB  -box -separator '  ' -batch "${SEARCH_STRING}"
        
        ;;
    url)
        shift 1
        importURLs "$*"
        ;;
    -h*|*) echo Usage
           cat <<EOF
$0 file file1....filen
    Import one or more files inside the doc collection
$0 search term
    Search
$0 url import1....
    Import one or more URL
EOF
;;
esac