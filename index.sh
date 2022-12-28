#!/bin/bash

set -eo pipefail
DB=${LEARN_DB:-~/.learndb-v1.sqlite3}
LEARN_HOME=$(dirname $0)
set -u

initDB() {
    dbfile="$1"
    echo "Initializing $dbfile"
    sqlite3 $dbfile -batch .quit -init $LEARN_HOME/ddl/01-setup.sql
}

importFiles(){
        set -x
            for elem in $* ; do
            sqlite3 $DB -batch  "INSERT INTO FILE_TO_LOAD VALUES ( '$(realpath $elem)' )"
        done
        sqlite3 $DB -batch .quit -init $LEARN_HOME/ddl/50-import.sql
}


# Main
test -f "$DB" || initDB "$DB"

set +u
case "$1" in 
    import)
        shift 1
        importFiles "$*"
        ;;
    search)
        shift 1
        SEARCH_STRING="select  path ||'(' || rank || ')', snippet(doc,1, '**','**','..',8) as f from doc where body match '$*' order by rank  limit 3"
        echo $SEARCH_STRING
        sqlite3 $DB  -separator '  ' -batch "${SEARCH_STRING}"
        
        ;;
    -h*|*) echo Usage
           cat <<EOF
$0 import file1....filen
    Import one or more files inside the doc collection
$0 search term
    Search
EOF
;;
esac