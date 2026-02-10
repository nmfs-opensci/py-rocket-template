FROM ghcr.io/nmfs-opensci/py-rocket-base:2026.02.07

LABEL org.opencontainers.image.maintainers="eli.holmes@noaa.gov"
LABEL org.opencontainers.image.author="eli.holmes@noaa.gov"
LABEL org.opencontainers.image.source=https://github.com/nmfs-opensci/py-rocket-template
LABEL org.opencontainers.image.description="Python (3.11) and R (4.5.1) image template"
LABEL org.opencontainers.image.licenses=Apache2.0
LABEL org.opencontainers.image.version=2026.02.10

USER root

# Copy the repo files into /tmp (environment.yml, install.R, etc)
COPY . /tmp/
# Fix permissions so NB_USER can write to /tmp during package installs
RUN chown -R ${NB_USER}:${NB_USER} /tmp && chmod -R 755 /tmp

# Install conda packages
RUN /pyrocket_scripts/install-conda-packages.sh /tmp/environment.yml || (echo "install conda packages failed" && exit 1)

# Install apt packages
RUN /pyrocket_scripts/install-apt-packages.sh /tmp/apt.txt || (echo "install-apt-packages.sh failed" && exit 1)

USER root
# Install R packages
# Ensure packages go to site-library whether installed via R, Rscript, or littler (r)
RUN echo '.libPaths("/usr/local/lib/R/site-library")' > /etc/littler.r && \
    echo '.libPaths("/usr/local/lib/R/site-library")' > /tmp/rprofile.site && \
    R_PROFILE=/tmp/rprofile.site \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    /pyrocket_scripts/install-r-packages.sh /tmp/install.R || (echo "install-r-packages.sh failed" && exit 1) && \
    rm /etc/littler.r /tmp/rprofile.site

# Clear out files put in /tmp
RUN rm -rf /tmp/*

USER ${NB_USER}
WORKDIR ${HOME}
