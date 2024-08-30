# Info
This is a Dockerfile for the upcoming integration of [OpenVDB](https://www.openvdb.org/) into [Neurovolume](https://github.com/joachimbbp/neurovolume)

It was made with [Zach Lipp](https://github.com/zachlipp) at the [Recurse Center](https://www.recurse.com/)

# To Do
## Dev Containers, Build, and Quality of Life 
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
- [ ] Pin "system dependencies"
    - You will have to rebuild `openvdb`, so allot ample downtime for this and make sure you have everything you need before doing so.
- [ ] Figure out a good naming difference between these two and name their respective `.txt` files accordingly

## Issues
### Pinning System Dependencies
The unpinned system dependencies were found in the running docker file with the following bash and Python commands:
```bash
nonroot@fcbfcffd04c7:/$ cmake --version
cmake version 3.25.1

nonroot@fcbfcffd04c7:/$ python3 --version
Python 3.11.2
```

```python
>>> import pybind11
>>> print(pybind11.__version__)
2.10.3
>>> 
```

```bash
nonroot@fcbfcffd04c7:/$ apt-cache madison python3-dev
python3-dev | 3.11.2-1+b1 | http://deb.debian.org/debian bookworm/main arm64 Packages
nonroot@fcbfcffd04c7:/$ 
```
However, when adding these version constraints:
```docker
RUN apt-get update && \
    apt-get install -y \
    libboost-iostreams-dev=1.74.0.3 \
    libtbb-dev=2021.8.0-2 \
    libblosc-dev=1.21.3+ds-1 \
    cmake=3.25.1 \
    python3=3.11.2 \
    python3-pybind11=2.10.3 \
    python3-dev=3.11.2-1+b1
```
We receive the following error:
```bash
...

=> ERROR [2/7] RUN apt-get update &&     apt-get install -y     libboost-iostreams-dev=1.74.0.3     libtbb-dev=2021.8.0-2     libblosc-dev=1.21.3+ds-1     cmake=3.25.1     python3=3.11.2     python3-pybind11=2.10.3     python3-dev=3.11.2-1+b1    1.9s
------                                                                                                                                                                                                                                                      
 > [2/7] RUN apt-get update &&     apt-get install -y     libboost-iostreams-dev=1.74.0.3     libtbb-dev=2021.8.0-2     libblosc-dev=1.21.3+ds-1     cmake=3.25.1     python3=3.11.2     python3-pybind11=2.10.3     python3-dev=3.11.2-1+b1:               
0.157 Get:1 http://deb.debian.org/debian bookworm InRelease [151 kB]                                                                                                                                                                                        
0.226 Get:2 http://deb.debian.org/debian bookworm-updates InRelease [55.4 kB]                                                                                                                                                                               
0.227 Get:3 http://deb.debian.org/debian-security bookworm-security InRelease [48.0 kB]                                                                                                                                                                     
0.295 Get:4 http://deb.debian.org/debian bookworm/main arm64 Packages [8688 kB]                                                                                                                                                                             
0.623 Get:5 http://deb.debian.org/debian bookworm-updates/main arm64 Packages [13.7 kB]
0.629 Get:6 http://deb.debian.org/debian-security bookworm-security/main arm64 Packages [176 kB]
1.272 Fetched 9132 kB in 1s (7887 kB/s)
1.272 Reading package lists...
1.558 Reading package lists...
1.805 Building dependency tree...
1.865 Reading state information...
1.868 Package python3 is not available, but is referred to by another package.
1.868 This may mean that the package is missing, has been obsoleted, or
1.868 is only available from another source
1.868 However the following packages replace it:
1.868   python3-dev
1.868 
1.868 Package cmake is not available, but is referred to by another package.
1.868 This may mean that the package is missing, has been obsoleted, or
1.868 is only available from another source
1.868 
1.868 Package python3-pybind11 is not available, but is referred to by another package.
1.868 This may mean that the package is missing, has been obsoleted, or
1.868 is only available from another source
1.868 
1.869 E: Version '3.25.1' for 'cmake' was not found
1.869 E: Version '3.11.2' for 'python3' was not found
1.869 E: Version '2.10.3' for 'python3-pybind11' was not found
------
Dockerfile:2
--------------------
   1 |     FROM gcc:14.2.0@sha256:4f7f4804d6fa49c371f0f3f54e72a352d865baa6917e79cff63d2b860c53197b
   2 | >>> RUN apt-get update && \
   3 | >>>     apt-get install -y \
   4 | >>>     libboost-iostreams-dev=1.74.0.3 \
   5 | >>>     libtbb-dev=2021.8.0-2 \
   6 | >>>     libblosc-dev=1.21.3+ds-1 \
   7 | >>>     cmake=3.25.1 \
   8 | >>>     python3=3.11.2 \
   9 | >>>     python3-pybind11=2.10.3 \
  10 | >>>     python3-dev=3.11.2-1+b1
  11 |     
--------------------
ERROR: failed to solve: process "/bin/sh -c apt-get update &&     apt-get install -y     libboost-iostreams-dev=1.74.0.3     libtbb-dev=2021.8.0-2     libblosc-dev=1.21.3+ds-1     cmake=3.25.1     python3=3.11.2     python3-pybind11=2.10.3     python3-dev=3.11.2-1+b1" did not complete successfully: exit code: 100

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/14ksc8l6gc8s13e4r4htgktm0
➜  openvdb_docker git:(main) ✗ 
```
These version constraints have thus been removed from this commit