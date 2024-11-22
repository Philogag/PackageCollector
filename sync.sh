#!/bin/bash

function download() {
  url=`lastversion --assets --filter "$2" "$1" 2>/dev/null`
  if [[ "x$url" = "x" ]]; then
    echo "Oops, get download url failed"
    exit -1
  fi

  url=`./hook_download_url.sh "$url"`
  file=".download/${url##*/}"
  mkdir -p .download
  wget -nv $url -O $file
  ./hook_after_download.sh $file
}

function sync() {
  version_remote=`lastversion "$1" 2>/dev/null`
  version_local=`cat .version 2>/dev/null | grep -E "^$1=" | cut -d '=' -f 2 `

  if [[ "x$version_remote" = "x" ]]; then
    echo "Oops, get remote version failed"
    exit -1
  fi

  # if no current version
  if [[ "x$version_local" = "x" ]]; then
    echo Download first version: $version_remote
    download $1 $2
    echo "$1=$version_remote" >> .version
    return
  fi

  version_newer=`lastversion "$version_remote" -gt "$version_local"`

  if [[ "x$version_local" = "x$version_remote" ]]; then
    echo Already newest	version: $version_remote
  elif [[ "x$version_newer" = "x$version_remote" ]]; then
    echo Find newer version: $version_local "=>" $version_remote
    download $1 $2
    sed -i "s@^$1=.*@$1=$version_remote@g" .version
  else
    echo Already newest	version: $version_remote
  fi
}

sync $1 $2

