ARG BASECONTAINER="opiopan/dlenv-core:cpu-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc4.2.0"

FROM ${BASECONTAINER}
LABEL maintainer "opiopan@gmail.com"

ARG OPENCV_VERSION="4.2.0"

#-----------------------------------------------------
# install essential and requiremented packages
#-----------------------------------------------------
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    vim less imagemagick ssh wget\
    cmake libgtk2.0-dev pkg-config libavcodec-dev \
    libavformat-dev libswscale-dev \
    libtbb2 libtbb-dev \
    libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev

#-----------------------------------------------------
# install gstreamer
#-----------------------------------------------------
RUN apt-get install -y --no-install-recommends \
    libgstreamer1.0-0 gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly gstreamer1.0-libav \
    gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x \
    gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 \
    gstreamer1.0-qt5 gstreamer1.0-pulseaudio
RUN apt-get install -y --no-install-recommends \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev


#-----------------------------------------------------
# install opencv
#-----------------------------------------------------
RUN mkdir /opencv
RUN CORENUM=$(grep processor /proc/cpuinfo | wc -l) && \
    PYVER=$(cat /.pyenv/version) && \
    PYDIR=/.pyenv/versions/${PYVER} && \
    PYMVER=$(echo $PYVER | sed 's/[.\-]/ /g' | \
                while read a b c; do echo $a.$b;done) && \
    cd /opencv && \
    git clone --depth=1 -b ${OPENCV_VERSION} --single-branch \
    	git://github.com/opencv/opencv.git && \
    git clone --depth=1 -b ${OPENCV_VERSION} --single-branch \
    	git://github.com/opencv/opencv_contrib && \
    mkdir build && \
    cd build && \
    cmake \
        -DCMAKE_BUILD_TYPE=RELEASE \
	-DOPENCV_GENERATE_PKGCONFIG=ON \
	-DBUILD_EXAMPLES=ON \
        -DINSTALL_C_EXAMPLES=ON \
        -DBUILD_NEW_PYTHON_SUPPORT=ON \
        -DBUILD_opencv_python3=ON \
        -DBUILD_opencv_legacy=OFF \
        -DINSTALL_PYTHON_EXAMPLES=ON \
        -DPYTHON_EXECUTABLE=${PYDIR}/bin/python \
        -DPYTHON_LIBRARY=${PYDIR}/lib/libpython${PYMVER}m.a \
        -DPYTHON_INCLUDE_DIR=${PYDIR}/include/python${PYMVER}m \
        -DPYTHON_INCLUDE_DIRS=${PYDIR}/include/python${PYMVER}m \
        -DPYTHON_INCLUDE_DIRS2=${PYDIR}/include/python${PYMVER}m \
        -DINCLUDE_DIRS=${PYDIR}/include/python${PYMVER}m \
        -DINCLUDE_DIRS2=${PYDIR}/include/python${PYMVER}m \
        -DPYTHON_PACKAGES_PATH=${PYDIR}/lib/python${PYMVER}/site-packages \
        -DPYTHON_NUMPY_INCLUDE_DIR=${PYDIR}/lib/python${PYMVER}/site-packages/numpy/core/include \
        -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
        -DWITH_1394=OFF -DWITH_GSTREAMER=ON -DWITH_FFMPEG=OFF \
        -D ENABLE_FAST_MATH=ON \
	__OPENCV_ADDITIONAL_OPTIONS__ \
        ../opencv && \
    make -j ${CORENUM} && \
    make install && \
    ln -s /usr/local/lib/python${PYMVER}/site-packages/cv2/ \
          /.pyenv/versions/${PYVER}/lib/python${PYMVER}/site-packages && \
    cd / && rm -rf opencv

#-----------------------------------------------------
# install additional python libraries
#-----------------------------------------------------
RUN pip install --upgrade pip && \
    pip install --no-cache-dir \
    ipython scipy sympy jupyter

#-----------------------------------------------------
# install additional packages
#-----------------------------------------------------
RUN apt-get install -y --no-install-recommends \
    v4l-utils

#-----------------------------------------------------
# clean up
#-----------------------------------------------------
RUN apt-get clean
