
# Docker Snippets for Callas PDFEngine SDK

> **Note:** for [pdfToolbox-cli](https://hub.docker.com/r/callassoftware/pdftoolbox-cli), [pdfaPilot-cli](https://hub.docker.com/r/callassoftware/pdfapilot-cli) and [pdfChip-cli](https://hub.docker.com/r/callassoftware/pdfchip-cli) there are "ready-to-use" [Docker images](https://hub.docker.com/u/callassoftware) on Docker hub. 

But there is no such aequivalent for the [callas PDFEngine SDK](https://help.callassoftware.com/m/pdftoolbox/c/233994) on Docker Hub. This is because it is not a standalone application, but a *Software Development Kit* intended for building custom applications.

This repository demonstrates how to containerize a custom application using the Callas PDFEngine SDK.

While the example mainly focuses on `sample-C/pdfToolbox` as a show case, the same approach can be adapted for *any* application built with the Callas PDFEngine SDK.

---

## Download and Unpack the SDK

```bash
# curl -LO https://www.callassoftware.com/extranet/callas_pdfEngineSDK/callas_pdfEngineSDK_arm64_Linux_17-0-683.tar.gz
curl -LO https://www.callassoftware.com/extranet/callas_pdfEngineSDK/callas_pdfEngineSDK_x64_Linux_17-0-683.tar.gz
tar xvpf callas_pdfEngineSDK_x64_Linux_17-0-683.tar.gz
mv callas_pdfEngineSDK_x64_Linux_17-0-683 callas_pdfEngineSDK_17-0-683
cp -p sample.pdf callas_pdfEngineSDK_17-0-683/sample-C/unix
```
note: please use `callas_pdfEngineSDK_arm64_Linux_17-0-683.tar.gz` for the **linux arm** variant

---

## Build the Docker Image

The provided [Dockerfile-debian](Dockerfile-debian) can be used to create a new docker image tagged with *callassoftware/pdfengine:v17-0-683*.

```bash
docker build -t callassoftware/pdfengine:v17-0-683 -f Dockerfile-debian .
```

---

## Run the Docker Container

You can now run the image to test an example operation, such as text extraction from a PDF. For concrete examples see the `usage examples` section below

---

## Notes

### License Server Integration

Inside Docker containers you must either use an [OEM license](https://oem.callassoftware.com/contact) or a [Callas License Server](https://help.callassoftware.com/m/licenseserver/l/1601616-using-the-license-server)

throughout these samples there are two 'special' url schemes used in the first and optionally the second sample parameters:

- `lss`:  
  One or more license server IPs or hostnames, separated by semicolons. Please note that this needs to be quoted if multiple servers are specified because otherwise the shell would interpret the ';' as a command separator

	example: `'lss://10.0.0.64;10.0.0.37'`

- `lsm`:  
  This is the aequivalent of the --lsmessage CLI argument for pdfToolbox, pdfaPilot and pdfChip CLIs. For [on-premise callas license server](https://help.callassoftware.com/c/257112) setups, this is not needed. But for [cloud-based SaaS callas license servers](https://help.callassoftware.com/m/licenseserver/l/1601616-using-the-license-server) it is mandatory.

	example: `lsm://fa043a4a-9152-b8f9-03f05a961da0`


## Usage examples ...

These examples will use the `sample.pdf` included in the Docker image and extract text from it to `sample.txt`.
```bash
# ... with a single license server ...
docker run --rm -ti callassoftware/pdfengine:v17-0-683 ./pdfToolboxSample lss://10.0.0.64 --extracttext sample.pdf sample.txt

# ... with multiple license servers ...
docker run --rm -ti callassoftware/pdfengine:v17-0-683 ./pdfToolboxSample 'lss://10.0.0.64;10.0.0.73' --extracttext sample.pdf sample.txt

# ... with an optional lsm argument (aka an --lsmessage aequivalent) ...
docker run --rm -ti callassoftware/pdfengine:v17-0-683 ./pdfToolboxSample lss://10.0.0.64 lsm://91cba468-7192-41e0-ad70-8510c0a5b1 --extracttext sample.pdf sample.txt

# ... with an OEM Licensecode ...
docker run --rm -ti callassoftware/pdfengine:v17-0-683 ./pdfToolboxSample <your OEM license code> --extracttext sample.pdf sample.txt
```

## Troubleshooting
> ** symptom: building the sample application succeeds but at runtime there is an error like this **
```
pdfToolboxSample.bin: lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by pdfToolboxSample.bin)
```

cause: pdfEngine-SDK has been compiled using gcc-9.5, but you are compiling the sample application with a newer compiler.

solution: remove the shipped lib/libstdc++.so.6 to fix it:

```bash
rm lib/libstdc++.so.6
```

> ** symptom: building the sample application fails because there is a linker error like this **
```
/usr/bin/ld: lib/libpdfEngine.so: undefined reference to `std::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::basic_stringstream()@GLIBCXX_3.4.26
```
cause: pdfEngine-SDK has been compiled using gcc-9.5, but you are compiling the sample application with an older compiler

solution: create a symbolic link to fix it:
```bash
cd lib
ln -s libstdc++.so.6 libstdc++.so
```

