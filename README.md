# docker-snippets
some docker related snippets and howtos for the pdfToolbox-cli

## ready to use docker images on Dockerhub
please see also our ready-to-use docker images on https://hub.docker.com/repository/docker/callassoftware/pdftoolbox-cli

note: Starting with pdfToolbox v15-1-639, these images support not only AMD64/Intel64, but also ARM64 as well
```
docker pull callassoftware/pdftoolbox-cli
docker pull callassoftware/pdftoolbox-cli:v16-0-656
docker pull callassoftware/pdftoolbox-cli:v16-0-656-essential
```
run preflight using the sample.kfpx/sample.pdf contained in the image
```
docker run --rm -ti callassoftware/pdftoolbox-cli ./pdfToolbox sample.kfpx sample.pdf --licenseserver=<ip of a callas license server>
```

## howto create your own docker images

assumption: there is a linux image build machine with the needed tools already installed (such as git, wget, tar, docker etc.)

### download pdfToolbox locally
```
git clone https://github.com/callassoftware/docker-snippets.git
cd docker-snippets
wget https://www.callassoftware.com/extranet/callas_pdfToolboxCLIandServer/callas_pdfToolboxCLI_x64_Linux_16-0-656.tar.gz
tar zxvpf callas_pdfToolboxCLI_x64_Linux_16-0-656.tar.gz
mv callas_pdfToolboxCLI_x64_Linux_16-0-656 callas_pdfToolboxCLI_Linux_16-0-656
```

### optional: reduce resulting image size
before building the image you can optionally reduce the size of the resulting image by removing some pdfToolbox parts that you don't need for you specific use case. In other words: you can also create "essential" images by yourself

```
cd callas_pdfToolboxCLI_Linux_16-0-656
bash ../reduce-essential.sh
cd ..
```

### build the image
```
docker build -t callassoftware/pdftoolbox-cli:v16-0-656 -f Dockerfile-debian $(pwd)
```

## ... try it out ...

```
docker run --rm -ti callassoftware/pdftoolbox-cli:v16-0-656 ./pdfToolbox --version
```
