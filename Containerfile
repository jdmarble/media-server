FROM ghcr.io/jdmarble/bootc-base:latest

# Copy system configuration later because this is where most changes will be made.
COPY /etc/ /etc/
COPY /usr/ /usr/

# https://docs.fedoraproject.org/en-US/bootc/building-containers/#_linting
RUN bootc container lint --fatal-warnings
