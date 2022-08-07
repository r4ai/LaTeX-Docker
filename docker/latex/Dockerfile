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
