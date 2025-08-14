
# Docker Snippets for Callas PDFEngine SDK

> **Note:** for `pdfToolbox`, `pdfaPilot`, or `pdfChip` there are "ready-to-use" [Docker images](https://hub.docker.com/u/callassoftware) on Docker hub. But there is no aequivalent for **PDFEngine SDK** on Docker Hub. This is because the PDFEngine SDK is not a standalone application, but a **Software Development Kit** intended for building custom applications.

To demonstrate how to containerize the sample-C/pdfToolbox application, this repository provides an example Dockerfile.

---

## Download and Unpack the SDK

```bash
# curl -LO https://www.callassoftware.com/extranet/callas_pdfEngineSDK/callas_pdfEngineSDK_arm64_Linux_16-1-662.tar.gz
curl -LO https://www.callassoftware.com/extranet/callas_pdfEngineSDK/callas_pdfEngineSDK_x64_Linux_16-1-662.tar.gz
tar xvpf callas_pdfEngineSDK_x64_Linux_16-1-662.tar.gz
mv callas_pdfEngineSDK_x64_Linux_16-1-662 callas_pdfEngineSDK_16-1-662
```

---

## Build the Docker Image

```bash
docker build -t callassoftware/pdfengine:v16-1-662 -f Dockerfile-debian .
```

---

## Run the Docker Container

You can now run the image to test an example operation, such as text extraction from a PDF:

```bash
docker run --rm -ti callassoftware/pdfengine:v16-1-662  \
                      ./pdfToolboxSample <your oem license code>  --extracttext sample.pdf sample.txt
```

This will use the `sample.pdf` included in the Docker image and extract its text to `sample.txt`.

---

## Notes

### License Server Integration

Inside Docker containers you must either use an OEM license or a **Callas License Server**

below you will find some instructions howto modify the sample programs to use a callas license server
 

throughout these samples there are two 'special' url schemes used in the first and optionally the second sample parameters:

- `lss:`:  
  One or more license server IPs or hostnames, separated by semicolons. Please note that this needs to be quoted if multiple servers are specified because otherwise the shell would interpret the ';' as a command separator

	example: e.g. 'lss://10.0.0.64;10.0.0.37'

- `lsm`:  
  This is the aequivalent of the --lsmessage CLI argument for pdfToolbox, pdfaPilot and pdfChip CLIs. For **on-premise** callas license server setups, this is not needed. But for **cloud-based** callas license servers it is mandatory.

	example: 'lsm://YjcxY2FmYTgtMzhkNC00NWZiL'


usage examples ...
```bash

docker run --rm -ti callassoftware/pdfengine:v16-1-662 ./pdfToolboxSample 'lss://10.0.0.64;10.0.0.37' --extracttext sample.pdf sample.txt


# ... with an optional lsm argument (aka an --lsmessage aequivalent) ...

docker run --rm -ti callassoftware/pdfengine:v16-1-662 ./pdfToolboxSample 'lss://10.0.0.64;10.0.0.37' 'lsm://YjcxY2FmYTgtMzhkNC00NWZiL' --extracttext sample.pdf sample.txt

```

This will use the `sample.pdf` included in the Docker image and extract its text to `sample.txt`.

### apply patches ...

note: these patches will no longer needed with newer releases of the callas pdfEngine SDK (but for v16-1-662 its needed)
```
cd callas_pdfEngineSDK_16-1-662
patch -p1 < pdfEngine-include.patch
patch -p1 < pdfEngine-samples.patch
 
```

### rebuild the Sample-C application to use a callas license server

```bash
cd callas_pdfEngineSDK_16-1-662/sample-C
cd unix
gmake
```

> **Troubleshooting 1:**  
pdfEngine-SDK has been compiled using gcc-9.5. If compiling the sample application succeeds but fails with a runtime error like this

```
./pdfToolboxSample
  pdfToolboxSample.bin: lib/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by pdfToolboxSample.bin)
```

then you are compiling the sample application with a newer compiler.  As a workaround you may need to remove the shipped lib/libstdc++.so.6 to fix it:

```bash
rm lib/libstdc++.so.6
```


> **Troubleshooting 2:**  
pdfEngine-SDK has been compiled using gcc-9.5. If you are encounter the following linker error:

```
/usr/bin/ld: lib/libpdfEngine.so: undefined reference to `std::basic_stringstream<char, std::char_traits<char>, std::allocator<char> >::basic_stringstream()@GLIBCXX_3.4.26'
```

then you are compiling the sample application with an older compiler.  As a workaround you may need to create a symbolic link to fix it:

```bash
cd lib
ln -s libstdc++.so.6 libstdc++.so
```

### rebuild the sample-DotNetCore application to use a callas license server

```bash
cd callas_pdfEngineSDK_x64_Linux_16-1-662/sample-DotNetCore
gmake
```

### rebuild the sample-java application to use a callas license server

```bash
cd callas_pdfEngineSDK_x64_Linux_16-1-662/sample-java
buildme.sh
```
