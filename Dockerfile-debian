FROM debian:latest AS debian-enriched
RUN apt-get update -y && apt-get upgrade -y \
        && apt-get install -y  \
                apt-utils  \
                lsb-release \
                procps \
                net-tools \
                perl-modules \
                fontconfig

FROM debian-enriched AS debian-enriched-with-fonts 
RUN apt-get install -y \
                libfreetype6 \
                fonts-dejavu

FROM debian-enriched-with-fonts AS pdftoolbox-installed
COPY callas_pdfToolboxCLI_x64_Linux_16-0-656 /opt/callas/callas_pdfToolboxCLI_x64_Linux_16-0-656

# add some "convenience" symlinks ...
RUN cd /opt/callas && ln -s callas_pdfToolboxCLI_x64_Linux_16-0-656 pdftoolbox-cli && ln -s callas_pdfToolboxCLI_x64_Linux_16-0-656 cli

# note: regarding the image size it doesn't really make a difference to clean or not
# FROM pdftoolbox-installed AS cleaned
# RUN apt-get autoremove \
#      && apt-get autoclean \
#      && rm -r -f /var/lib/apt/lists \
#      && rm -r -f /usr/share/doc \
#      && rm -r -f /usr/share/man

WORKDIR /opt/callas/callas_pdfToolboxCLI_x64_Linux_16-0-656
