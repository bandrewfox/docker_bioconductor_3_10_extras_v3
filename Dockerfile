FROM ghcr.io/bandrewfox/docker_bioconductor_3_10_extras:main

# set CRAN snapshot repository and save to Rprofile
RUN echo 'options(repos = c(CRAN = "https://packagemanager.posit.co/cran/2022-01-21"))' > ~/.Rprofile
RUN echo 'options(BioC_mirror = "https://packagemanager.posit.co/bioconductor")' >> ~/.Rprofile

RUN install2.r --error gridtext 
RUN install2.r --error ggpubr
RUN install2.r --error survminer
   

# Fix for Debian Buster EOL repositories to allow security upgrades
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list && \
    apt-get update -o Acquire::Check-Valid-Until=false && \
    apt-get upgrade -y -o Acquire::Check-Valid-Until=false && \
    apt-get clean
