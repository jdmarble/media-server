# Media Server

This repository contains configuration and code to create a disk image for a simple media streaming server.
The operating system is an immutable variant of Fedora constructed by [`bootc`](https://docs.fedoraproject.org/en-US/bootc).
The server runs [Jellyfin](https://jellyfin.org/) for video media.
It does not host the media files, but mounts them from an NFS server.
The image can be installed on bare-metal with an installation disc image constructed by [bootc-image-builder](https://docs.fedoraproject.org/en-US/bootc/provisioning-generic/#_using_anaconda_for_generic_installations).
See the `bootc` documentation for other deployment methods, such as VM images.
Regardless of the installation method,
updates are applied automatically by pulling container images from this repository's container registry.

## Installation

These are steps for initial installation of the server.
Software and configuration updates are built and distributed from CI.
Since the initial installer images are large and require root priviledges to build,
I've chosen not to build them in CI.

### Prerequisites

Clone this repository to a build system running Linux.
Building on MacOS or WSL2 on Windows may also work, but may require some patches to the build scripts.

If you have [jetify devbox](https://www.jetify.com/devbox) and [direnv](https://direnv.net/) installed,
simply run `direnv allow` to download the required tools and configure the build environment.

Otherwise, look at the packages section of the `devbox.json` file for a list of build tools.
Some notes on certain tools:

podman
: You need to have permissions to run Podman in "rootful" mode to build disk images.

qemu
: QEMU is optional unless you want to test images in a local VM.

### Customization

Edit the user credentials in `config.toml`.
If you fail to do this before building, there will be a default user with an insecure password!

Create SystemD overlays to customize the NFS mounts for media and Jellyfin configuration.

TODO: Create more detailed instructions on how to do this here.

### Bare Metal

To install on a bare metal server, use the software in this repository to build a OS install ISO image.
Then, boot from the image as you would any OS installer.

To build the image, clone this repository and run the following command:

```sh
just anaconda-iso
```

Burn the resulting `output/bootiso/install.iso` to bootable media and install as you would any other OS.
During installation, Anaconda _may_ prompt you for the installation destination disk.
If there is only a single disk available, **it will overwrite the entire disk without asking**.

### Credentials

After installation, run the following command as root on the device so the Cloudflare plugin for Caddy can configure DNS records for a Let's Encrypt certificate challenge.

```sh
echo CF_API_TOKEN=your_cloudflare_API_token_here | systemd-creds encrypt --name=caddy_credentials - /etc/credstore.encrypted/caddy_credentials
```
