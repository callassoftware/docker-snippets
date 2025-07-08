# docker snippets for callas pdfEngine-SDK

note: Unlike pdfToolbox, pdfaPilot, or pdfChip, there are no prebuilt "ready-to-use" Docker images for the pdfEngine SDK available on Docker Hub. This is because the pdfEngine SDK is not a standalone application, but a Software Development Kit intended for building custom applications.

To demonstrate how to containerize such a use case, we provide an example Dockerfile using one of the precompiled sample C applications with some modifications that are needed to use a callas license server instead of a local 'activation'. This serves as a practical reference to highlight the necessary prerequisites and setup steps.

## download and unpack and patch the pdfEngine-SDK tar.gz installer 
```
wget https://www.callassoftware.com/extranet/callas_pdfEngineSDK/callas_pdfEngineSDK_x64_Linux_16-0-657.tar.gz
tar callas_pdfEngineSDK_x64_Linux_16-0-657.tar.gz
mv callas_pdfEngineSDK_x64_Linux_16-0-657 callas_pdfEngineSDK_16-0-657
cd callas_pdfEngineSDK_16-0-657 callas_pdfEngineSDK_16-0-657/sample-C
patch -p0 < ../../pdfToolboxSample.cpp.patch
cd unix
gmake
```

## build the docker image
```
docker build -t callassoftware/pdfengine:v16-0-657 -f Dockerfile-debian $(pwd)
```

## ... try it out ...

e.g. perform an _--extracttext_ operation using the sample.pdf (contained in the image)

```
docker run --rm -ti -e 'CALLAS_LICENSESERVER_URLS=10.0.0.64;10.0.0.37' -e 'CALLAS_LICENSESERVER_MSG=asdfasdfasdfsdfsdf' callassoftware/pdfengine:v16-0-657 ./pdfToolboxSample ignore ignore --extracttext sample.pdf sample.txt
```

as you can see there are some "specials things" here. First a value of 'ignore' is used for the two keycodes that normally can be passed to the pdfToolbox sample applicaton when it is run without a docker environment. Second there are two 
enviroment variables passed to the docker container ...

 - CALLAS_LICENSESERVER_URLS contains one ore more License Server IP addresses (or hostnames), separated by a semicolon
 - CALLAS_LICENSESERVER_MSG contains an optional wallet-id to be passed to the callas License Servers specified via CALLAS_LICENSESERVER_URLS. This is typically optional for en premise License Servers, but mandatory for the licenseserver in the cloud

