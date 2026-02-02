# bioconductor base docker with extras on top of my previous build

This repo uses this Docker image as the base layer:
https://github.com/bandrewfox/docker_bioconductor_3_10_extras/pkgs/container/docker_bioconductor_3_10_extras

I didn't want to rebuild the whole thing, so I am adding on top of that one

Then I copied my v2 Dockerfile and added OS upgrade lines:
https://github.com/bandrewfox/docker_bioconductor_3_10_extras_v2
