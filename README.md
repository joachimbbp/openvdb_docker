# Branch info
Branch for fixing the cmake flags as well as possibly fixing some CI issues

# Docker for OpenVDB
This project is a Dockerfile for [OpenVDB](https://www.openvdb.org/) with `NumPy` support and all grid types enabled. It is used in [Neurovolume](https://github.com/joachimbbp/neurovolume) but should also be applicable to many scientific visualization projects.

It was made by [Zach Lipp](https://github.com/zachlipp) and Joachim Pfefferkorn (but mostly Zach) at the [Recurse Center](https://www.recurse.com/)

# Pull Requests
Before submitting a pull request, please make sure that the docker file builds on your machine with our github actions.
To do so using [act](https://github.com/nektos/act):
- navigate to `openvdb_docker`
- run `act -j build`

# Commit Notes
Returing to dockerfile from commit `25e3169feac1c34c236ca0ee8f98d159e4ef78c6` as current multi-stage builds were proving problematic. This is a minimum viable product for Neurovolume.
Github actions have changed to `workflow_dispatch` only.

# To Do
## Dev and Build
- [ ] Configure the Dev Container with Python
- [ ] Learn how to not copy Dev Container directories
- [ ] Multistage Build
- [ ] Docker Compose File for developer experience
- [ ] Install VScode Python extension
- [ ] Install Jupyter Python extension
## Dependencies
- [x] Install all other dependencies with docker container
    - [x] Pin their versions
    - [x] Move Jupyter dependency from global install to a simple Python dependency
    - [x] Figure out a DRYer and less verbose `pipx` installation technique
    - [x] Install `nilearn` in neurovolume_deps.txt`
- [x] Pin "system dependencies"
- [x] Figure out a good naming difference between these two and name their respective `.txt` files accordingly
    - Created a 'neurovolume_deps.txt' specifically for [neurovolume](https://github.com/joachimbbp/neurovolume). This allows other projects to easily swap out their own dependencies.
## Github Actions
- [x] Test the github actions
- [ ] Lock action versions (`checkout@v4` etc )
- [x] Cache and/or retain the Docker image (either by integrating into dockerhub or by github action log retention)
    - [x] Make this this retained Docker image has a dynamic, unique, meaningful name (perhaps include time and date)
