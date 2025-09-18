FROM ghcr.io/jdmarble/bootc-base:latest

# Enable Caddy to reverse proxy the Jellyfin server
RUN systemctl enable caddy.service

RUN dnf install \
    rclone \
    && dnf clean all && rm -rf /var/log/* /var/cache /var/lib/{dnf,rpm-state,rhsm}

# Copy system configuration later because this is where most changes will be made.
COPY /usr/ /usr/

# https://docs.fedoraproject.org/en-US/bootc/building-containers/#_linting
RUN bootc container lint --fatal-warnings
