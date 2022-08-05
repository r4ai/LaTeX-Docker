FROM pandoc/latex:latest

#* LaTeX plugins
RUN tlmgr update --self --all && \
    tlmgr install \
    bxjscls \
    luatexja \
    collection-langjapanese \
    ctex \
    type1cm \
    babel-japanese \
    bxwareki \
    everyhook \
    svn-prov && \
    tlmgr update latex

#* Font
RUN tlmgr install \
    ipaex \
    haranoaji && \
    apk add --no-cache \
    ttf-droid \
    ttf-droid-nonlatin

#* github actions
RUN apk update && apk add \
    bash \
    git \
    wkhtmltopdf

#* html-template
RUN wget -O - https://github.com/ryangrose/easy-pandoc-templates/archive/master.tar.gz | \
    tar zxvf - -C /tmp/ \
    && mv /tmp/easy-pandoc-templates* /usr/lib/easy-pandoc-templates \
    && rm -rf /tmp/*


WORKDIR /build
