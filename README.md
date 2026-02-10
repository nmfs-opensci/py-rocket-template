# py-rocket-template
A template for using [py-rocket-base](https://nmfs-opensci.github.io/py-rocket-base/) (Python+R in a Pangeo+Rocker UI) for creating Docker image for JupyterHubs.

py-rocket-base creates the consistent Pangeo-esque user interface + all the niceties like making sure the R environment is separate from conda, the publishing suite is installed, ssh is ready, Desktop installed, etc. Your derivative images will add the Python and R packages that you want. Note, in py-rocket-base, R has a core set of standard packages (tidyverse) while Python mainly has things needed for the JupyterHub/JupyterLab/Dask UI.

## Using this template

When you use this template to create your own repository:

1. Update the `environment.yml` file with your conda packages
2. Update the `install.R` file with your R packages  
3. Update the `apt.txt` file with any system packages
4. Update the Dockerfile labels (maintainers, author, description)
5. The Docker image will be automatically built and pushed to GitHub Container Registry when you push changes to main. Look on the right nav bar of your repository for the link to your Docker image.

The image name will automatically be set to your repository name.
