# py-rocket-template
A template for using [py-rocket-base](https://nmfs-opensci.github.io/py-rocket-base/) (Python+R in a Pangeo+Rocker UI) for creating Docker image for JupyterHubs.

## Using this template

When you use this template to create your own repository:

1. Update the `environment.yml` file with your conda packages
2. Update the `install.R` file with your R packages  
3. Update the `apt.txt` file with any system packages
4. Update the Dockerfile labels (maintainers, author, description)
5. The Docker image will be automatically built and pushed to GitHub Container Registry when you push changes to main

The image name will automatically be set to your repository name.
