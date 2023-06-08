# LaTeX-Docker　[![Build and push docker image](https://github.com/e9716/LaTeX-Docker/actions/workflows/docker-image.yml/badge.svg?branch=main)](https://github.com/e9716/LaTeX-Docker/actions/workflows/docker-image.yml)

my pandoc $\mathrm{\LaTeX}$ environment.
This repository contains the following two Dockerfiles

1. [r4ai/latex](https://hub.docker.com/r/r4ai/latex)
   - based on [paperist/texlive-ja](https://github.com/Paperist/texlive-ja)
   - includes **luatex, xelatex ...**
   - amd64 & arm64 support. (M1 support)
1. [r4ai/pandoc](https://hub.docker.com/r/r4ai/pandoc)
   - based on r4ai/latex.
   - includes **pandoc, pandoc-crossref, easy-pandoc-templates** ...
   - **not arm64** support. only support amd64.
     (because pandoc-crossref couldn't be built with arm64 debian)

## how to build

### r4ai/latex (texlive)

```bash
docker build -f docker/latex/Dockerfile -t r4ai/latex:latest .
```

### r4ai/pandoc (pandoc)

```bash
docker build -f docker/pandoc/Dockerfile -t r4ai/pandoc:latest .
```

## how to use

### r4ai/latex

Compile .tex and generate pdf.
For example, the following command generates a `main.pdf` from `main.tex`.

```bash
docker run --rm -it \
    --volume $PWD:/workdir r4ai/latex:latest \
    sh -c 'ptex2pdf -l -ot -kanji=utf8 -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error main.tex'
```

### r4ai/pandoc

Generate PDF from markdown by LaTeX.
For example, the following command generates a `output.pdf` from `input.md`.

```bash
docker run --rm \
    --volume "$(pwd):/build" \
    --user $(id -u):$(id -g) \
    r4ai/pandoc:latest input.md -o output.pdf \
        --pdf-engine=xelatex \
        -V documentclass=bxjsarticle \
        -V classoption=pandoc \
        -M listings --listings \
        -H /settings/header.tex \
        -H /settings/deeplists.tex \
        --metadata-file /settings/metadata.yml \
        -F pandoc-crossref
```

Generate PDF from markdown by html5.
For example, the following command generates a `output.pdf` from `input.md`.

```bash
docker run --rm \
    --volume "$(pwd):/build" \
    r4ai/pandoc:latest input.md -o output.pdf \
        -t html5 \
        --template=easy_template.html \
        --metadata-file /settings/metadata.yml \
        -F pandoc-crossref
```

## how to debug

### r4ai/pandoc

open bash.

```bash
docker run --rm -it \
      --volume "$(pwd):/build" \
      --entrypoint /bin/bash \
      r4ai/pandoc:latest
```
