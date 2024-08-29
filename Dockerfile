FROM gcc:14.2.0@sha256:4f7f4804d6fa49c371f0f3f54e72a352d865baa6917e79cff63d2b860c53197b
RUN apt-get update && \
    apt-get install -y \
    libboost-iostreams-dev=1.74.0.3 \
    libtbb-dev=2021.8.0-2 \
    libblosc-dev=1.21.3+ds-1 \
    cmake \
    python3 \
    python3-pybind11 \
    python3-dev
    # TODO: pin all unpinned versions

RUN git clone https://github.com/AcademySoftwareFoundation/openvdb.git && \
    cd openvdb && \
    mkdir build && \
    cd build && \
    cmake .. -D OPENVDB_BUILD_PYTHON_MODULE=ON && \
    make && \ 
    make install
    
RUN apt-get install -y python3-pip pipx

RUN useradd -ms /bin/bash nonroot
USER nonroot

RUN pipx install --include-deps jupyter

ENTRYPOINT [ "sleep", "infinity" ]