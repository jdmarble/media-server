FROM quay.io/fedora/fedora-bootc:42

# Configure package manager before installing packages.
COPY /etc/dnf /etc/dnf

# Install packages in an early layer because this is mostly stable.
RUN dnf install \
      nfs-utils \
      cockpit \
    && dnf clean all \
    && rm -rf /var/cache/yum

# Automatically update quadlet managed container images.
RUN systemctl enable podman-auto-update.timer \
 && systemctl enable cockpit.socket

# Disable SSH daemon
#RUN systemctl disable sshd.service \
# && systemctl mask sshd.service

# Copy system configuration later because this is where most changes will be made.
COPY /etc/ /etc/
COPY /usr/ /usr/

# https://docs.fedoraproject.org/en-US/bootc/building-containers/#_linting
RUN bootc container lint
