FROM gcc:14.2.0@sha256:4f7f4804d6fa49c371f0f3f54e72a352d865baa6917e79cff63d2b860c53197b AS builder

RUN apt-get update && \
    apt-get install -y \
    libboost-iostreams-dev=1.74.0.3 \
    libtbb-dev=2021.8.0-2 \
    libblosc-dev=1.21.3+ds-1 \
    cmake=3.25.1-1 \
    python3-pybind11=2.10.3-1 \
    python3-dev=3.11.2-1+b1 \
    python3-venv=3.11.2-1+b1 \
    python3-pip=23.0.1+dfsg-1

RUN git clone https://github.com/AcademySoftwareFoundation/openvdb.git && \
    cd openvdb && \
    git checkout a759e477aad3f305585ae85c6c723769a7e5f2cf && \
    mkdir build && \
    cd build && \
    cmake .. -DOPENVDB_BUILD_PYTHON_MODULE=ON -DUSE_NUMPY=ON && \
    make && \
    make install

RUN useradd -ms /bin/bash nonroot

WORKDIR /home/nonroot

USER nonroot

COPY neurovolume_deps.txt .

# This path doesn't exist yet; we create it in the next layer
ENV PATH="/home/nonroot/.venv/bin:$PATH"

RUN python3 -m venv .venv && \
    # TODO: Parametrize?
    pip install -r neurovolume_deps.txt

ENTRYPOINT [ "sleep", "infinity" ]