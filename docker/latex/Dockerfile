FROM paperist/texlive-ja:latest

RUN apt-get update \
    && apt-get install -y \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

RUN tlmgr update --self --all && tlmgr update latex \
    tlmgr install \
    luatexja \
    bxjscls \
    collection-langjapanese \
    babel-japanese \
    bxwareki \
    everyhook \
    svn-prov \
    type1cm \
    ipaex \
    haranoaji \
    collection-xetex \
    svn-prov \
    ctex

RUN cp -r /usr/local/texlive/2023/texmf-dist/fonts/truetype/public/ipaex/ /usr/share/fonts/truetype/ && \
    cp -r /usr/local/texlive/2023/texmf-dist/fonts/opentype/public/haranoaji/ /usr/share/fonts/opentype/ && \
    cp -r /usr/local/texlive/2023/texmf-dist/fonts/opentype/public/haranoaji-extra/ /usr/share/fonts/opentype/
