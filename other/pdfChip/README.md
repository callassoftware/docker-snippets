# docker snippets for callas pdfChip

## ready to use pdfChip docker images on Dockerhub
e.g. perform a _HTML to PDF conversion_ using the hello.html (contained in the image)

```
docker run --rm -ti callassoftware/pdfchip ./pdfChip hello.html output.pdf --licenseserver=<ip of a callas license server>
```

## howto create your own pdfChip docker image

### download and unpack the pdfChip tar.gz installer 
```
wget https://www.callassoftware.com/extranet/callas_pdfChip/callas_pdfChip_x64_Linux_2-6-098.tar.gz
tar zxvpf callas_pdfChip_x64_Linux_2-6-098.tar.gz
mv callas callas_pdfChip_x64_Linux_2-6-098 callas_pdfChip_Linux_2-6-098
```

### build the docker image
```
docker build -t callassoftware/pdfchip:v2-6-098 -f Dockerfile-debian $(pwd)
```
