# Info
This project is a Dockerfile for [OpenVDB](https://www.openvdb.org/) with `NumPy` support. It is used in [Neurovolume](https://github.com/joachimbbp/neurovolume) but should also be applicable to many scientific visualization projects.

It was made by [Zach Lipp](https://github.com/zachlipp) and Joachim Pfefferkorn (but mostly Zach) at the [Recurse Center](https://www.recurse.com/)

# To Do
## Dev and Build
- [ ] Configure the Dev Container with Python
- [ ] Learn how to not copy Dev Container directories
- [ ] Multistage Build
- [ ] Docker Compose File for developer experience
- [ ] Install vscode Python extension
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
