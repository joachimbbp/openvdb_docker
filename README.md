# Info
This is a Dockerfile for the upcoming integration of [OpenVDB](https://www.openvdb.org/) into [Neurovolume](https://github.com/joachimbbp/neurovolume)

It was made with [Zach Lipp](https://github.com/zachlipp) at the [Recurse Center](https://www.recurse.com/)

# To Do
## Dev and Build
- [ ] Configure the Dev Container with Python
- [ ] Learn how to not copy Dev Container directories
- [ ] Multistage Build
- [ ] Docker Compose File for developer experience
- [ ] Install vscode Python extension
## Dependencies
- [x] Install all other dependencies with docker container
    - [x] Pin their versions
    - [x] Move Jupyter dependency from global install to a simple Python dependency
    - [x] Figure out a DRYer and less verbose `pipx` installation technique
- [x] Pin "system dependencies"
- [x] Figure out a good naming difference between these two and name their respective `.txt` files accordingly
    - Created a 'neurovolume_deps.txt' specifically for [neurovolume](https://github.com/joachimbbp/neurovolume). This allows other projects to easily swap out their own dependencies.
