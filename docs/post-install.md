# Post Installation Procedure

## Configure Reverse Proxy

```sh
ansible-playbook --inventory=inventory_dev.ini --become --ask-become-pass playbooks/setup-tls-reverse-proxy.yaml
```

## Configure Media Mounts

If you do not store your media on your `media-manager` instance,
you can configure how it connects to your media storage by
overriding the `var-mnt-media.mount` unit with a systemd drop-in.

Edit the inventory variables for the `file-server` host before using any of the referenced playbooks.

### NFS Mounted Media Share

Configure your file server to allow the media server to connect to the media mount with read and write access.

```sh
ansible-playbook --inventory=inventory_prod.yaml --become --ask-become-pass playbooks/nfs-media-mount.yaml
```

## Configure Jellyfin

1. Go to https://jellyfin.example.com
2. Go through the on-boarding procedure
  1. Create an admin account
  2. Add media libraries
    * Content type "Movies" in `/media/movies` folder
    * Content type "Shows" in `/media/shows` folder

## Configure Sonarr

1. Go to https://sonarr.example.com
2. Go through the on-boarding procedure to configure authentication
  * Authentication Method: Forms (Login Page)
  * Authentication Required: Enabled
  * Create and admin account
3. "Settings/Media Management"
  * Add Root Folder: `/download`

...

## Configure Prowlarr

1. Go to https://prowlarr.example.com
2. Go through the on-boarding procedure to configure authentication
  * Authentication Method: Forms (Login Page)
  * Authentication Required: Enabled
  * Create and admin account
3. Add Indexers in the "Indexers" tab
  * Protocol: torrent
  * Language: en-US
  * Privacy: Public
4. Add Apps in the "Settings/Apps" tab
  * ...
5. ... "Settings/Download Clients" tab
