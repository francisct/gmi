#!/bin/sh

set -e
gitmodules_file=.gitmodules.gmi

if [ ! -f $gitmodules_file ]; then 
        echo "$gitmodules_file missing" && exit 1 
fi

git config -f $gitmodules_file --get-regexp '^submodule\..*\.path$' |
    while read path_key path
    do
        url_key=$(echo $path_key | sed 's/\.path/.url/')
        url=$(git config -f $gitmodules_file --get "$url_key")
        git submodule add $url $path
        url_entry=$(cat $gitmodules_file | grep $url)
        commit=${url_entry#*#}
        if [ "$commit" != "$url" ]; then
                echo "gmi: versioning detected, checking out to $commit"
                git -C $path reset --hard $commit
        fi
    done