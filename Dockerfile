FROM pandoc/latex:latest

#* LaTeX plugins
RUN tlmgr update --self --all && \
    tlmgr install \
    bxjscls \
    bxwareki \
    everyhook \
    luatexja \
    svn-prov \
    type1cm && \
    tlmgr update latex

#* 日本語化
RUN tlmgr install \
    babel-japanese \
    ipaex \
    haranoaji

#* その他
RUN apk add --no-cache \
    ttf-droid \
    ttf-droid-nonlatin

#* html-template
RUN wget -O - https://github.com/ryangrose/easy-pandoc-templates/archive/master.tar.gz | \
    tar zxvf - -C /tmp/ \
    && mv /tmp/easy-pandoc-templates* /usr/lib/easy-pandoc-templates \
    && rm -rf /tmp/*
