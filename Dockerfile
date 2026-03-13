FROM ghcr.io/bandrewfox/docker_bioconductor_3_10_extras:main

# set CRAN snapshot repository and save to Rprofile
RUN echo 'options(repos = c(CRAN = "https://packagemanager.posit.co/cran/2022-01-21"))' > ~/.Rprofile
RUN echo 'options(BioC_mirror = "https://packagemanager.posit.co/bioconductor")' >> ~/.Rprofile

RUN install2.r --error gridtext 
RUN install2.r --error ggpubr
RUN install2.r --error survminer

# Legacy fixes from install_extra_packages.R
RUN R -q -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/rvcheck/rvcheck_0.1.8.tar.gz", repos = NULL, type = "source")'
RUN R -q -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/yulab.utils/yulab.utils_0.0.1.tar.gz", repos = NULL, type = "source")'

# Bioconductor packages from install_extra_packages.R
RUN R -q -e 'BiocManager::install(c("clusterProfiler","enrichplot","DOSE","GOSemSim"), version = "3.10", update = FALSE, ask = FALSE, force = TRUE)'

# Fix for Debian Buster EOL repositories to allow security upgrades
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list && \
    apt-get update -o Acquire::Check-Valid-Until=false && \
    apt-get upgrade -y -o Acquire::Check-Valid-Until=false && \
    apt-get clean

