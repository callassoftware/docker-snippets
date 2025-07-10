# docker snippets for callas pdfChip

## ready to use pdfChip docker images on Dockerhub
e.g. perform an _HTML to PDF conversion_ using hello.html (contained in the image)

```
docker run --rm -ti callassoftware/pdfchip-cli ./pdfChip hello.html output.pdf --licenseserver=<ip of a callas license server>
```

## howto create your own pdfChip docker image

### download and unpack the pdfChip tar.gz installer 
```
wget https://www.callassoftware.com/extranet/callas_pdfChip/callas_pdfChip_x64_Linux_2-6-098.tar.gz
tar zxvpf callas_pdfChip_x64_Linux_2-6-098.tar.gz
mv callas_pdfChip_2_x64_Linux_2-6-098 callas_pdfChip_2-6-098
cp hello.html callas_pdfChip_2-6-098
```

### build the docker image
```
docker build -t callassoftware/pdfchip-cli:v2-6-098 -f Dockerfile-debian .
```
