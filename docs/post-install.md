# Post Installation Procedure

## Configure Reverse Proxy

```sh
ansible-playbook --inventory=inventory_dev.ini --become --ask-become-pass playbooks/setup-tls-reverse-proxy.yaml
```

## Configure Media Mounts

### NFS Mounted Media Share

### Local Media Only

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
