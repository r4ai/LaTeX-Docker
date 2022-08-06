# LaTeX-Docker

my pandoc $\mathrm{\LaTeX}$ environment.  
includes below two Dockerfiles.

1. r4ai/latex
2. r4ai/pandoc

## how to build.
### r4ai/latex (texlive)
```bash
docker build -f docker/latex/Dockerfile -t r4ai/latex:latest .
```

### r4ai/pandoc (pandoc)
```bash
docker build -f docker/pandoc/Dockerfile -t r4ai/pandoc:latest .
```

## how to use.
### compile .tex and generate pdf. (r4ai/latex)
```bash
docker run --rm -it \
    --volume $PWD:/workdir r4ai/latex:latest \
    sh -c 'ptex2pdf -l -ot -kanji=utf8 -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error main.tex'
```

### generate pdf from md using LaTeX. (r4ai/pandoc)
```bash
docker run --rm \
    --volume "$(pwd):/data" \
    --user $(id -u):$(id -g) \
    --mount type=volume,src=ltcache,dst=/usr/local/texlive/2021/texmf-var/luatex-cache \
    pandoc/latex-ja:latest input.md -o output.pdf \
        --pdf-engine=lualatex \
        -V lang=ja \
        -V documentclass=ltjsarticle
```
