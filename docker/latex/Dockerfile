FROM paperist/texlive-ja:latest

RUN apt-get update \
  && apt-get install -y \
    libfontconfig1 \
  && rm -rf /var/lib/apt/lists/*

RUN tlmgr install collection-xetex ctex
