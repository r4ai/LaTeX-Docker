FROM r4ai/latex:latest
COPY docker/pandoc/pandoc_installer.sh /tmp/
COPY docker/pandoc/header.tex /settings/
COPY docker/pandoc/metadata.yml /settings/
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    curl \
    gawk \
    xz-utils
RUN tlmgr update --self --all && tlmgr update latex \
    tlmgr install \
    luatexja \
    bxjscls \
    bxwareki \
    everyhook \
    svn-prov \
    type1cm \
    ipaex \
    haranoaji
RUN /tmp/pandoc_installer.sh "arm64"
ENTRYPOINT [ "/usr/bin/pandoc" ]
WORKDIR /build
