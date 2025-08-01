FROM debian:12-slim

RUN apt-get update -y && apt-get upgrade -y \
        && apt-get install -y  \
                apt-utils  \
                procps \
                net-tools \
                fontconfig  \
                fonts-dejavu \
                libatomic1 

# avoid installing the full /usr/bin/lsb_release package, which can be several megabytes in size. Use a lightweight mock implementation instead.
COPY lsb_release_mockup.sh /usr/bin
RUN test -x /usr/bin/lsb_release || ln -s /usr/bin/lsb_release_mockup.sh  /usr/bin/lsb_release

# optional - install microsoft truetype fonts ...
# RUN sed -i 's,main,main contrib non-free non-free-firmware,' /etc/apt/sources.list.d/debian.sources
# RUN apt-get update -y && apt-get install -y ttf-mscorefonts-installer

# optional - install libreoffice (only needed to convert office documents to pdf). Note: this adds nearly 700MB to the image ...
# RUN apt-get install --no-install-recommends libreoffice-nogui liblibreoffice-java default-jre-headless

COPY callas_pdfToolboxCLI_Linux_16-1-662 /opt/callas/callas_pdfToolboxCLI_Linux_16-1-662

# add some "convenience" symlinks ...
RUN cd /opt/callas && ln -s callas_pdfToolboxCLI_Linux_16-1-662 pdftoolbox-cli && ln -s callas_pdfToolboxCLI_Linux_16-1-662 cli

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

WORKDIR /opt/callas/callas_pdfToolboxCLI_Linux_16-1-662

