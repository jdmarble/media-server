FROM quay.io/fedora/fedora-bootc:42

# Configure package manager before installing packages.
COPY /etc/dnf /etc/dnf

# Install packages in an early layer because this is mostly stable.
# nfs-utils: To mount the media share over NFS
# cockpit: Remote management web UI
RUN dnf install \
      nfs-utils \
      cockpit \
    && dnf clean all \
    && rm -rf /var/cache/yum

# Automatically update quadlet managed container images.
# Disable SSH daemon to reduce attack surface.
# Enable Cockpit for remote management and to increase attack surface.
RUN systemctl enable podman-auto-update.timer \
 && systemctl disable sshd.service \
 && systemctl mask sshd.service \
 && systemctl enable cockpit.socket

# Copy system configuration later because this is where most changes will be made.
COPY /etc/ /etc/
COPY /usr/ /usr/

# https://docs.fedoraproject.org/en-US/bootc/building-containers/#_linting
RUN bootc container lint
