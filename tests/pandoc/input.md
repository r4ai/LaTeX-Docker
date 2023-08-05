---
title: hello,world!
author: r4ai
date: \today
---

# hello, world

とある計算：
$$
1 + 1 = 2
$$

pandoc と $\text{\LaTeX}$ が入った Dockerfile ([@lst:Dockerfile])。

```{.txt caption="Dockerfile" #lst:Dockerfile}
FROM r4ai/latex:latest
COPY docker/pandoc/pandoc_installer.sh /tmp/
COPY docker/pandoc/header.tex /settings/
COPY docker/pandoc/deeplists.tex /settings/
COPY docker/pandoc/metadata.yml /settings/
ARG TARGETARCH
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    curl \
    git \
    gawk \
    xz-utils \
    wkhtmltopdf
# Install pandoc, pandoc-crossref, easy-pandoc-templates
RUN chmod -R +x /tmp/ && \
    /tmp/pandoc_installer.sh ${TARGETARCH} && \
    curl 'https://raw.githubusercontent.com/ryangrose/easy-pandoc-templates/master/copy_templates.sh' | bash &&
ENTRYPOINT [ "/usr/bin/pandoc" ]
WORKDIR /build
```
