# docker-snippets
some docker related snippets and howtos for the pdfToolbox-cli

## ready to use docker images on Dockerhub
please see also our ready-to-use docker images on https://hub.docker.com/repository/docker/callassoftware/pdftoolbox-cli

note: images tagged with _essential_ have been reduced by following the instructions from https://help.callassoftware.com/m/pdftoolbox/l/793898-file-components-and-their-use-in-pdftoolbox-sdk⁠ (see also reduce-essential.sh)

note: Starting with v15-1-639, these images have manifests that support not only AMD64/Intel64, but also ARM64 as well
```
docker pull callassoftware/pdftoolbox-cli
docker pull callassoftware/pdftoolbox-cli:v15-2-639
docker pull callassoftware/pdftoolbox-cli:v15-2-639-essential
```
run preflight using the sample.kfpx/sample.pdf contained in the image
```
docker run --rm -ti callassoftware/pdftoolbox-cli ./pdfToolbox sample.kfpx sample.pdf --licenseserver=<ip of a callas license server>
```

