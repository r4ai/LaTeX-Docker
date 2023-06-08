#!/bin/bash

function pandoc_install() {
  arch="$1"
  readonly arch

  if [ "${arch}" != "amd64" ] && [ "${arch}" != "arm64" ]; then
    echo "ERROR: The first argument must be either amd64 or arm64."
    echo "ERROR: Failed to install pandoc."
    return 0
  fi

  pandoc_url=$(
    curl -s https://api.github.com/repos/jgm/pandoc/releases/latest |
      grep "browser_download_url.*${arch}.deb" |
      cut -d : -f 2,3 |
      tr -d \ \"
  )
  readonly pandoc_url

  pandoc_file_name=$(
    echo "${pandoc_url}" | gawk 'match($0, /\/([^\/]+$)/, a){print a[1]}'
  )
  readonly pandoc_file_name

  wget "${pandoc_url}"
  apt-get install -y "./${pandoc_file_name}"
  rm "${pandoc_file_name}"
  return 0
}

function pandoc-crossref_install() {
  pandoc_crossref_url=$(
    curl -s https://api.github.com/repos/lierdakil/pandoc-crossref/releases/latest |
      grep "browser_download_url.*Linux.tar.xz" |
      cut -d : -f 2,3 |
      tr -d \ \"
  )
  readonly pandoc_crossref_url

  pandoc_crossref_file_name=$(
    echo "${pandoc_crossref_url}" | gawk 'match($0, /\/([^\/]+)\.tar\.xz$/, a){print a[1]}'
  )
  readonly pandoc_crossref_file_name

  wget "${pandoc_crossref_url}"
  xz -dv "${pandoc_crossref_file_name}.tar.xz" &&
    tar xfv "${pandoc_crossref_file_name}.tar" &&
    rm -rf pandoc-crossref.1 &&
    rm -f "${pandoc_crossref_file_name}.tar" &&
    mv pandoc-crossref /usr/bin/
}

pandoc_install "$1"
if [ "$1" == "amd64" ]; then
  pandoc-crossref_install
fi
