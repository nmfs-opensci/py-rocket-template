#! /usr/local/bin/Rscript
# install R dependencies

# CRAN binaries repo (from image build)
repo <- "https://p3m.dev/cran/__linux__/noble/2025-10-30"

# Guardrail: don't install into /home in the Docker build context
install_lib <- .libPaths()[1]
if (grepl("^/home", install_lib)) {
  stop(
    "Error: Packages are being installed to /home, which will be removed in the final image. Exiting.",
    call. = FALSE
  )
}

# Main R ecosystem installed via rocker scripts: https://github.com/rocker-org/rocker-versioned2/scripts
# Tidyverse packages are installed via install_tidyverse.sh
# Geospatial packages are installed via install_geospatial.sh

# Extra packages
list.of.packages <- c(
  "reticulate",
  "quarto",
  "kableExtra"
)
install.packages(list.of.packages, repos = repo)
