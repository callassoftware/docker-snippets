# docker-snippets

Docker build recipes, examples, and operational notes for callas products - primarily **pdfToolbox CLI**.

> Docker snippets for other callas products, including pdfaPilot and pdfChip, are available in the [`other/`](./other/) directory.

## Contents

- [Use the published image](#use-the-published-image)
- [Build a custom image](#build-a-custom-image)
- [Verify the image](#verify-the-image)

## Use the published image

Ready-to-use `pdfToolbox CLI` images are published on [Docker Hub](https://hub.docker.com/repository/docker/callassoftware/pdftoolbox-cli).

Pull the latest image:

```bash
docker pull callassoftware/pdftoolbox-cli
```

### Run the bundled preflight example

The image includes `sample.kfpx` and `sample.pdf`. The following command runs the preflight profile and writes the output PDF to `/tmp/output.pdf` inside the container:

```bash
docker run --rm -it \
  callassoftware/pdftoolbox-cli \
  ./pdfToolbox sample.kfpx sample.pdf \
  -o=/tmp/output.pdf \
  --licenseserver=<CALLAS_LICENSE_SERVER_IP>
```

Replace `<CALLAS_LICENSE_SERVER_IP>` with the address of your callas license server.

> The container is removed automatically when the command finishes because of `--rm`. Mount a host directory with `-v` if you need to retain generated files outside the container.

## Build a custom image

Use this procedure to build an image with a specific pdfToolbox CLI release or a reduced component set.

### Prerequisites

Perform the build on a Linux machine with the following commands available:

- `git`
- `wget`
- `tar`
- `docker` (including permission to run `docker build`)

### Download pdfToolbox CLI

Clone this repository and download the desired pdfToolbox CLI .tar.gz archive. Update the version in the commands below when building for a different release.

```bash
git clone https://github.com/callassoftware/docker-snippets.git
cd docker-snippets

wget https://www.callassoftware.com/extranet/callas_pdfToolboxCLIandServer/callas_pdfToolboxCLI_x64_Linux_17-0-682.tar.gz

tar zxvpf callas_pdfToolboxCLI_x64_Linux_17-0-682.tar.gz
mv callas_pdfToolboxCLI_x64_Linux_17-0-682 callas_pdfToolboxCLI_Linux_17-0-682
```

For newer Debian-based distributions, such as Debian Trixie, the bundled `libstdc++.so.6` is not required and can be removed before building:

```bash
rm callas_pdfToolboxCLI_Linux_17-0-682/lib/libstdc++.so.6
```

Keep the bundled library when targeting older Debian-based distributions.

### Optionally reduce the image size

If your workflow does not require all pdfToolbox components, use `reduce-essential.sh` to remove unneeded components before building. This creates a smaller, purpose-built image.

```bash
cd callas_pdfToolboxCLI_Linux_17-0-682
bash ../reduce-essential.sh
cd ..
```

### Build the image

Build the Debian-based image and tag it with the pdfToolbox version:

```bash
docker build \
  -t callassoftware/pdftoolbox-cli:v17-0-682 \
  -f Dockerfile-debian \
  .
```

## Verify the image

Confirm that the newly built image starts and reports the installed version:

```bash
docker run --rm -it \
  callassoftware/pdftoolbox-cli:v17-0-682 \
  ./pdfToolbox --version
```

If the command succeeds, the image is ready to use.
