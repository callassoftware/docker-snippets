# docker-snippets
some docker related snippets and howtos for the pdfToolbox-cli

## ready to use docker images on Dockerhub
please see also our ready-to-use docker images on https://hub.docker.com/repository/docker/callassoftware/pdftoolbox-cli

note: images tagged with _essential_ have been reduced by following the instructions from https://help.callassoftware.com/m/pdftoolbox/l/793898-file-components-and-their-use-in-pdftoolbox-sdk⁠
```
docker pull callassoftware/pdftoolbox-cli
docker pull callassoftware/pdftoolbox-cli:v15-1-639
docker pull callassoftware/pdftoolbox-cli:v15-1-639-essential
```
run preflight using the sample.kfpx/sample.pdf contained in the image
```
docker run --rm -ti callassoftware/pdftoolbox-cli ./pdfToolbox sample.kfpx sample.pdf --licenseserver=<ip of a callas license server>
```

## Dockerfile Example
per default our docker images on dockerhub are based on debian linux

```
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
COPY callas_pdfToolboxCLI_x64_Linux_15-1-639 /opt/callas/callas_pdfToolboxCLI_x64_Linux_15-1-639

# add some "convenience" symlinks ...
RUN cd /opt/callas && ln -s callas_pdfToolboxCLI_x64_Linux_15-1-639 pdftoolbox-cli && ln -s callas_pdfToolboxCLI_x64_Linux_15-1-639 cli

# note: regarding the image size it doesn't really make a difference to clean or not
# FROM pdftoolbox-installed AS cleaned
# RUN apt-get autoremove \
#      && apt-get autoclean \
#      && rm -r -f /var/lib/apt/lists \
#      && rm -r -f /usr/share/doc \
#      && rm -r -f /usr/share/man

WORKDIR /opt/callas/callas_pdfToolboxCLI_x64_Linux_15-1-639
```
