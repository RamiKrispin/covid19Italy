FROM docker.io/rkrispin/baser_dev:v4.1.0

LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"

# installing R packages
RUN mkdir packages
COPY install_packages.R packages/
RUN Rscript packages/install_packages.R
COPY install_geo_packages.R packages/
RUN Rscript packages/install_geo_packages.R

RUN sudo apt-get update && sudo apt-get install pandoc -y
