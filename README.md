# docker-snippets
some docker related snippets and howtos for the pdfToolbox-cli

## ready to use docker images on Dockerhub
please see also our ready-to-use docker images on https://hub.docker.com/repository/docker/callassoftware/pdftoolbox-cli

note: Starting with pdfToolbox v15-1-639, these images also support ARM64 now (not only AMD64/Intel64)
```
docker pull callassoftware/pdftoolbox-cli
docker pull callassoftware/pdftoolbox-cli:v15-2-639
docker pull callassoftware/pdftoolbox-cli:v15-2-639-essential
```
run preflight using the sample.kfpx/sample.pdf contained in the image
```
docker run --rm -ti callassoftware/pdftoolbox-cli ./pdfToolbox sample.kfpx sample.pdf --licenseserver=<ip of a callas license server>
```


## howto create your own docker images

assumption: there is a linux image build machine with the needed tools already installed (such as git, wget, tar, docker etc.)

```
git clone https://github.com/callassoftware/docker-snippets.git
cd docker-snippets
wget https://www.callassoftware.com/extranet/callas_pdfToolboxCLIandServer/callas_pdfToolboxCLI_x64_Linux_15-2-646.tar.gz
tar xvpf callas_pdfToolboxCLI_x64_Linux_15-2-646.tar.gz
docker build -t callas/pdftoolbox:v15-2-646 -f Dockerfile-debian $(pwd)
```
