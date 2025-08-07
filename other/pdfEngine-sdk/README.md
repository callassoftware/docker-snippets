
# Docker Snippets for Callas PDFEngine SDK

> **Note:** Unlike `pdfToolbox`, `pdfaPilot`, or `pdfChip`, there are no prebuilt "ready-to-use" Docker images for the **PDFEngine SDK** on Docker Hub. This is because the PDFEngine SDK is not a standalone application, but a **Software Development Kit** intended for building custom applications.

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

Because Docker containers don't support local hardware-based license activations, you must either use an OEM license or a **Callas License Server**

below you will find some instructions howto modify the sample programs to use a callas license server
 
> **Note:** these sample modifications only works for the case when a license server is to be used. It is not needed (and not working) for OEM licensing

throughout these samples there are two environment variables used:

- `CALLAS_LICENSESERVER_URLS`:  
  One or more license server IPs or hostnames, separated by semicolons.

- `CALLAS_LICENSESERVER_MSG`:  
  An optional wallet ID required by **cloud-based** callas license servers. For **on-premise** setups, this is typically optional (it is the aequivalent of the --lsmessage CLI argument for pdfToolbox, pdfaPilot and pdfChip CLIs)

usage example ...
```bash
docker run --rm -ti   -e 'CALLAS_LICENSESERVER_URLS=10.0.0.64;10.0.0.37' \
                      -e 'CALLAS_LICENSESERVER_MSG=retpifdghsetrwerrwh'   \
                      callassoftware/pdfengine:v16-1-662  \
                      ./pdfToolboxSample ignore --extracttext sample.pdf sample.txt
```

This will use the `sample.pdf` included in the Docker image and extract its text to `sample.txt`.

**Note:** The `ignore` value in the example command simply represents a placeholder keycode. You can use any arbitrary string in its place.  These are normally required when running the unmodified sample app locally but are ignored for the modified samples programs. 

### Patch and Rebuild the Sample-C Application to use a callas license server

```bash
cd callas_pdfEngineSDK_16-1-662/sample-C
patch -p0 < ../../sample-C.patch
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

### Patch and Rebuild the sample-DotNetCore Application to use a callas license server

```bash
cd callas_pdfEngineSDK_x64_Linux_16-1-662/sample-DotNetCore
patch -p0 < ../../sample-DotNetCore.patch
gmake
```

### Patch and Rebuild the sample-java Application to use a callas license server

```bash
cd callas_pdfEngineSDK_x64_Linux_16-1-662/sample-java
patch -p0 < ../../sample-java.patch
buildme.sh
```
