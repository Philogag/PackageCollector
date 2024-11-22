#!/bin/bash

# $1 is the file path where already download, do any thing you want

echo $1 download success!
FILE=$1
EXT=${FILE##*.}

# this is a rpm package, upload to my gitea package manager!
if [[ x"$EXT" =~ x"rpm" ]]; then
    echo Upload to my gitea
    curl --user $GITEA_USER:$GITEA_TOKEN \
        --upload-file $FILE \
        $GITEA_HOST/api/packages/${GITEA_USER}/rpm/upload
    echo Done.
fi


