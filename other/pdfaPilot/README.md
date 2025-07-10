# docker snippets for the callas pdfaPilot-cli

## ready to use pdfaPilot-cli docker images on Dockerhub
e.g. perform a _PDF/A analyze_ using the sample.pdf (contained in the image)

```
docker run --rm -ti callassoftware/pdfapilot-cli ./pdfaPilot --analyze sample.pdf --licenseserver=<ip of a callas license server>
```

## howto create your own pdfaPilot-cli docker image

### download and unpack the pdfaPilot tar.gz installer 
```
# note: for Linux ARM use https://www.callassoftware.com/extranet/callas_pdfaPilotCLIandServer/callas_pdfaPilotCLI_arm64_Linux_14-0-392.tar.gz
wget https://www.callassoftware.com/extranet/callas_pdfaPilotCLIandServer/callas_pdfaPilotCLI_x64_Linux_14-0-392.tar.gz
tar zxvpf callas_pdfaPilotCLI_x64_Linux_14-0-392.tar.gz
mv callas_pdfaPilotCLI_x64_Linux_14-0-392 callas_pdfaPilotCLI_Linux_14-0-392
cp sample.pdf callas_pdfaPilotCLI_Linux_14-0-392
```

### build the docker image
```
docker build -t callassoftware/pdfapilot-cli:v14-0-392 -f Dockerfile-debian .
```
