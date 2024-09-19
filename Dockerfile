FROM gcc:14.2.0@sha256:4f7f4804d6fa49c371f0f3f54e72a352d865baa6917e79cff63d2b860c53197b AS builder

RUN apt-get update && \
    apt-get install -y \
    libboost-iostreams-dev=1.74.0.3 \
    libtbb-dev=2021.8.0-2 \
    libblosc-dev=1.21.3+ds-1 \
    cmake=3.25.1-1 \
    python3-pybind11=2.10.3-1 \
    python3-dev=3.11.2-1+b1

RUN git clone https://github.com/AcademySoftwareFoundation/openvdb.git && \
    cd openvdb && \
    git checkout a759e477aad3f305585ae85c6c723769a7e5f2cf && \
    mkdir build && \
    cd build && \
    cmake .. -D OPENVDB_BUILD_PYTHON_MODULE=ON -D USE_NUMPY=ON -D PY_OPENVDB_WRAP_ALL_GRID_TYPES=ON && \
    make && \
    make install

FROM python:3.11-slim@sha256:50ec89bdac0a845ec1751f91cb6187a3d8adb2b919d6e82d17acf48d1a9743fc

# --- cpp ---
COPY --from=builder \
  # openvdb binaries
  /openvdb/build/openvdb/openvdb/libopenvdb.so* \
  # build dependencies from ldd
  /lib/aarch64-linux-gnu/libtbb.so.12 \
  /lib/aarch64-linux-gnu/libblosc.so.1 \
  /lib/aarch64-linux-gnu/libz.so.1 \
  /lib/aarch64-linux-gnu/libboost_iostreams.so.1.74.0 \
  /lib/aarch64-linux-gnu/libm.so.6 \
  /lib/aarch64-linux-gnu/liblz4.so.1 \
  /lib/aarch64-linux-gnu/libsnappy.so.1 \
  /lib/aarch64-linux-gnu/libzstd.so.1 \
  /lib/aarch64-linux-gnu/libbz2.so.1.0 \
  /lib/aarch64-linux-gnu/liblzma.so.5 \
  /usr/local/lib64/libstdc++.so.6 \
  /usr/local/lib64/libgcc_s.so.1 \
  /lib/aarch64-linux-gnu \
# --- python ---
COPY --from=builder \
  /openvdb/build/openvdb/openvdb/python/pyopenvdb.cpython-311-aarch64-linux-gnu.so /usr/local/lib/python3.11/site-packages/

RUN useradd -ms /bin/bash nonroot

WORKDIR /home/nonroot

USER nonroot

COPY neurovolume_deps.txt .

RUN python3 -m venv .venv && \
    # TODO: Parametrize?
    pip install -r neurovolume_deps.txt

ENTRYPOINT [ "sleep", "infinity" ]