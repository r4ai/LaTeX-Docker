FROM r4ai/latex:latest
COPY docker/pandoc/pandoc_installer.sh /tmp/
COPY docker/pandoc/header.tex /settings/
COPY docker/pandoc/metadata.yml /settings/
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    curl \
    gawk \
    xz-utils \
    wkhtmltopdf
RUN chmod -R 777 /tmp/ && \
    /tmp/pandoc_installer.sh 'amd64'
ENTRYPOINT [ "/usr/bin/pandoc" ]
WORKDIR /build
