# LaTeX-Docker
my pandoc LaTeX environment.

## how to build.
```bash
docker build -f Dockerfile -t pandoc/latex-ja:latest .
```

## how to use.
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
