# Yocto Builder
This is a docker container that provides all of the tools needed to build
a yocto project.

## Current targeted version
Gatesgarth is the version of yocto used in Xilinx 2021.1 tools. It uses
v.148 of bitbake.

## Installation
Run the following command in this directory:
```
docker build --tag yocto_builder:gatesgarth .
```

## Running
Run in the base directory of a yocto project:
```
docker run -v ${PWD}:/host -it -w /host yocto_builder:gatesgarth
```
