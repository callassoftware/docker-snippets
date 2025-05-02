# note: for multistage builds see https://docs.docker.com/develop/develop-images/multistage-build

FROM debian
RUN apt-get update -y && apt-get upgrade -y \
        && apt-get install -y  \
                apt-utils  \
                net-tools \
                fontconfig  \
                fonts-dejavu \
				libatomic1

# avoid installing the full /usr/bin/lsb_release package, which can be several megabytes in size. Use a lightweight mock implementation instead.
COPY lsb_release_mockup.sh /usr/bin
RUN test -x /usr/bin/lsb_release || ln -s /usr/bin/lsb_release_mockup.sh  /usr/bin/lsb_release

# optional - install microsoft truetype fonts ...
# RUN apt-get install -y ttf-mscorefonts-installer

# optional - install libreoffice (only needed to convert office documents to pdf). Note: this adds nearly 700MB to the image ...
# apt-get install --no-install-recommends libreoffice liblibreoffice-java default-jre-headless

COPY callas_pdfToolboxCLI_x64_Linux_16-0-657 /opt/callas/callas_pdfToolboxCLI_x64_Linux_16-0-657

# add some "convenience" symlinks ...
RUN cd /opt/callas && ln -s callas_pdfToolboxCLI_x64_Linux_16-0-657 pdftoolbox-cli && ln -s callas_pdfToolboxCLI_x64_Linux_16-0-657 cli

WORKDIR /opt/callas/callas_pdfToolboxCLI_x64_Linux_16-0-657

