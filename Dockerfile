FROM ghcr.io/nmfs-opensci/py-rocket-base:2026.02.07

ARG REPO_URL=https://github.com/OWNER/REPO

LABEL org.opencontainers.image.maintainers="your.name"
LABEL org.opencontainers.image.author="your.name"
LABEL org.opencontainers.image.source=${REPO_URL}
LABEL org.opencontainers.image.description="Python (3.11) and R (4.5.1) image template"
LABEL org.opencontainers.image.licenses=Apache2.0
LABEL org.opencontainers.image.version=2026.02.10

USER root

# Copy the repo files into /tmp (environment.yml, install.R, etc)
COPY . /tmp/

# Install conda packages
RUN /pyrocket_scripts/install-conda-packages.sh /tmp/environment.yml || (echo "install conda packages failed" && exit 1)

# Install apt packages
RUN /pyrocket_scripts/install-apt-packages.sh /tmp/apt.txt || (echo "install-apt-packages.sh failed" && exit 1)

# Install R packages
RUN /pyrocket_scripts/install-r-packages.sh /tmp/install.R || (echo "install-r-packages.sh failed" && exit 1)

# Clear out files put in /tmp
RUN rm -rf /tmp/*

USER ${NB_USER}
WORKDIR ${HOME}
