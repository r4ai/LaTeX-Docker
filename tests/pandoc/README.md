---
title: hello,world!
author: r4ai
date: \today
---

# hello, world!

とある計算
$$
1 + 1 = 2
$$

pandocをinstallするシェルスクリプト([@lst:pandoc_installer.sh])。

```{.sh caption="pandoc_installer.sh" #lst:pandoc_installer.sh}
#!/bin/bash
function pandoc_install() {
    local readonly arch="$1"
    if [ "${arch}" != "amd64" ] && [ "${arch}" != "arm64" ]; then
        echo "ERROR: The first argument must be either amd64 or arm64."
        echo "ERROR: Failed to install pandoc."
        return 0
    fi
    local readonly pandoc_url=$(
        curl -s https://api.github.com/repos/jgm/pandoc/releases/latest \
            | grep "browser_download_url.*${arch}.deb" \
            | cut -d : -f 2,3 \
            | tr -d \ \"
    )
    local readonly pandoc_file_name=$(
        echo ${pandoc_url} | gawk 'match($0, /\/([^\/]+$)/, a){print a[1]}'
    )
    wget ${pandoc_url}
    apt-get install -y "./${pandoc_file_name}"
    rm ${pandoc_file_name}
    return 0
}
```
