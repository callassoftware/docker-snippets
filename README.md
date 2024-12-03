# docker-snippets
some docker related snippets and howtos for the pdfToolbox-cli

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
per default only debian based docker images are provided on our dockerhup repository

```
# note: for multistage builds see https://docs.docker.com/develop/develop-images/multistage-build

FROM debian:latest AS debian-enriched
RUN apt-get update -y && apt-get upgrade -y \
        && apt-get install -y  \
                apt-utils  \
                lsb-release \
                procps \
                net-tools \
                vim-tiny  \
                perl-modules  \
                wget  \
                curl  \
                jq

FROM debian-enriched AS debian-enriched-with-fonts
RUN apt-get install -y \
                fontconfig  \
                libfreetype6 \
                fonts-dejavu

FROM debian-enriched-with-fonts AS pdftoolbox-installed
COPY callas_pdfToolboxCLI_x64_Linux_15-1-639 /opt/callas/callas_pdfToolboxCLI_x64_Linux_15-1-639
COPY Dockerfile.versioned /Dockerfile

# RUN ln -s /opt/callas/callas_pdfToolboxCLI_x64_Linux_15-1-639 /opt/callas/pdftoolbox-cli
RUN cd /opt/callas && ln -s callas_pdfToolboxCLI_x64_Linux_15-1-639 pdftoolbox-cli && ln -s callas_pdfToolboxCLI_x64_Linux_15-1-639 cli

# note: regarding the image size it doesn't really make a difference to clean or not
# FROM pdftoolbox-installed AS cleaned
# RUN apt-get autoremove \
#      && apt-get autoclean \
#      && rm -r -f /var/lib/apt/lists \
#      && rm -r -f /usr/share/doc \
#      && rm -r -f /usr/share/man

WORKDIR /opt/callas/callas_pdfToolboxCLI_x64_Linux_15-1-639

# finally the "complicated" stuff ...
# long: https://www.bmc.com/blogs/docker-cmd-vs-entrypoint/
# short ...
#   ENTRYPOINT specifies default parameters that cannot be overridden. it can be used for initial setup (e.g. install fonts)
#   CMD specifies default parameters that can be overridden
# ENTRYPOINT ["/bin/bash"]
# CMD ["/bin/bash"]
```
