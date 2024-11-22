#!/bin/bash

# $1 is the url going to download, do any thing as you want and then echo the new url!
url=$1

# if [[ "$url" =~ "https://github.com" ]]; then
#     # 加速github下载
#     echo https://ghproxy.net/$url
#     exit
# fi

echo $url

