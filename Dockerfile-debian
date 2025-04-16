# note: for multistage builds see https://docs.docker.com/develop/develop-images/multistage-build

FROM debian
RUN apt-get update -y && apt-get upgrade -y \
        && apt-get install -y  \
                apt-utils  \
                lsb-release \
                procps \
                net-tools \
                fontconfig  \
                fonts-dejavu

# optional - install microsoft truetype fonts ...
# RUN apt-get install -y ttf-mscorefonts-installer

# optional - install libreoffice (only needed to convert office documents to pdf). Note: this adds nearly 700MB to the image ...
# apt-get install --no-install-recommends libreoffice liblibreoffice-java default-jre-headless

COPY callas_pdfToolboxCLI_x64_Linux_16-0-656 /opt/callas/callas_pdfToolboxCLI_x64_Linux_16-0-656

# add some "convenience" symlinks ...
RUN cd /opt/callas && ln -s callas_pdfToolboxCLI_x64_Linux_16-0-656 pdftoolbox-cli && ln -s callas_pdfToolboxCLI_x64_Linux_16-0-656 cli

WORKDIR /opt/callas/callas_pdfToolboxCLI_x64_Linux_16-0-656

