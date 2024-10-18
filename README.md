# Docker for OpenVDB
This project is a Dockerfile for [OpenVDB](https://www.openvdb.org/). It includes NumPy support and default grids (`FloatGrid`, `BoolGrid`, and `Vec3sGrid`) only for fast build times.

This dockerfile is intended for local builds. It does not specify system architecture and will default to whatever architecture you build it on.

This dockerfile is used in [Neurovolume](https://github.com/joachimbbp/neurovolume) but should also be applicable to many scientific visualization projects.

It was made by [Zach Lipp](https://github.com/zachlipp) and Joachim Pfefferkorn (but mostly Zach) at the [Recurse Center](https://www.recurse.com/)

# Pull Requests
Before submitting a pull request, please make sure that the docker file builds on your machine with our github actions.
To do so using [act](https://github.com/nektos/act):
- navigate to `openvdb_docker`
- run `act -j build`

# Future Work
- A multi-architecture build which pushes directly to Dockerhub has been been in the works (see previous commits and other branches). While we have had limited success with these, we would like to implement this in the future.
- Similarly, an [enabling of all grid types](https://www.openvdb.org/documentation/doxygen/python.html) is interesting to us if there is a way to make this performant.
