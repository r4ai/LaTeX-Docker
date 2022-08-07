# LaTeX-Docker

my pandoc $\mathrm{\LaTeX}$ environment.  
includes below two Dockerfiles.

1. r4ai/latex  
   - based on [paperist/texlive-ja](https://github.com/Paperist/texlive-ja)  
   - includes **luatex, xelatex ...**
   - amd64 & arm64 support. (M1 support)
1. r4ai/pandoc
   - based on r4ai/latex.
   - includes **pandoc, pandoc-crossref** ...
   - **not arm64** support. only support amd64.  
     (because pandoc-crossref couldn't build with arm64 debian)

# how to build.
## r4ai/latex (texlive)
```bash
docker build -f docker/latex/Dockerfile -t r4ai/latex:latest .
```

## r4ai/pandoc (pandoc)
```bash
docker build -f docker/pandoc/Dockerfile -t r4ai/pandoc:latest .
```

# how to use.
## compile .tex and generate pdf. (r4ai/latex)
```bash
docker run --rm -it \
    --volume $PWD:/workdir r4ai/latex:latest \
    sh -c 'ptex2pdf -l -ot -kanji=utf8 -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error main.tex'
```

## generate pdf from md using LaTeX. (r4ai/pandoc)
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
        --metadata-file /settings/metadata.yml \
        -F /usr/lib/pandoc-crossref
```

# how to debug.

## r4ai/pandoc
open bash.
```bash
docker run --rm -it \
      --volume "$(pwd):/build" \
      --entrypoint /bin/bash \
      r4ai/pandoc:latest
```
