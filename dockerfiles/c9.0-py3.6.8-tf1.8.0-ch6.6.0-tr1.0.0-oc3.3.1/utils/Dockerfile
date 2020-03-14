ARG BASECONTAINER="opiopan/dlenv-core:c9.0-py3.6.8-tf1.8.0-ch6.6.0-tr1.0.0-oc3.3.1"

FROM ${BASECONTAINER}
LABEL maintainer "opiopan@gmail.com"

ARG OPENCV_VERSION="3.3.1"

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
ARG GSTREAMER_VERSION="1.14.5"

RUN apt-get install -y --no-install-recommends \
    yasm \
    gtk-doc-tools liborc-0.4-0 liborc-0.4-dev libvorbis-dev \
    libcdparanoia-dev libcdparanoia0 cdparanoia libvisual-0.4-0 \
    libvisual-0.4-dev libvisual-0.4-plugins libvisual-projectm \
    vorbis-tools vorbisgain libopus-dev libopus-doc libopus0 \
    libopusfile-dev libopusfile0 libtheora-bin libtheora-dev \
    libtheora-doc libvpx-dev libvpx-doc libvpx3 libqt5gstreamer-1.0-0 \
    libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
    libflac++-dev libavc1394-dev libraw1394-dev libraw1394-tools \
    libraw1394-doc libraw1394-tools libtag1-dev libtagc0-dev \
    libwavpack-dev wavpack bison flex && \
    apt-get install -y --no-install-recommends \
    libfontconfig1-dev libfreetype6-dev libx11-dev libxext-dev \
    libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libx11-xcb-dev \
    libxcb-glx0-dev && \
    apt-get install -y --no-install-recommends \
    libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev \
    libxcb-icccm4-dev libxcb-sync0-dev libxcb-xfixes0-dev \
    libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev && \
    apt-get install -y --no-install-recommends \
    libfontconfig1-dev libdbus-1-dev libfreetype6-dev libudev-dev && \
    apt-get install -y --no-install-recommends \
    libasound2-dev libavcodec-dev libavformat-dev libswscale-dev && \
    apt-get install -y --no-install-recommends \
    libicu-dev libsqlite3-dev libxslt1-dev libssl-dev

RUN git clone --depth=1 -b ${GSTREAMER_VERSION} --single-branch \
    git://anongit.freedesktop.org/gstreamer/gstreamer && \
    cd gstreamer && \
    ./autogen.sh && \
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -r gstreamer

RUN REPNAME=gst-plugins-base && \
    git clone --depth=1 -b ${GSTREAMER_VERSION} --single-branch \
    git://anongit.freedesktop.org/git/gstreamer/${REPNAME} && \
    cd ${REPNAME} && \
    ./autogen.sh && \
    ./configure --enable-opengl=no &&\
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -r ${REPNAME}

RUN REPNAME=gst-plugins-good && \
    git clone --depth=1 -b ${GSTREAMER_VERSION} --single-branch \
    git://anongit.freedesktop.org/git/gstreamer/${REPNAME} && \
    cd ${REPNAME} && \
    ./autogen.sh && \
    ./configure --enable-opengl=no &&\
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -r ${REPNAME}

RUN REPNAME=gst-plugins-bad && \
    git clone --depth=1 -b ${GSTREAMER_VERSION} --single-branch \
    git://anongit.freedesktop.org/git/gstreamer/${REPNAME} && \
    cd ${REPNAME} && \
    ./autogen.sh && \
    ./configure --enable-opengl=no &&\
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -r ${REPNAME}

RUN REPNAME=gst-plugins-ugly && \
    git clone --depth=1 -b ${GSTREAMER_VERSION} --single-branch \
    git://anongit.freedesktop.org/git/gstreamer/${REPNAME} && \
    cd ${REPNAME} && \
    ./autogen.sh && \
    ./configure --enable-opengl=no &&\
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -r ${REPNAME}

RUN REPNAME=gst-libav && \
    git clone --depth=1 -b ${GSTREAMER_VERSION} --single-branch \
    git://anongit.freedesktop.org/git/gstreamer/${REPNAME} && \
    cd ${REPNAME} && \
    ./autogen.sh && \
    ./configure --enable-opengl=no &&\
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -r ${REPNAME}


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
        -D WITH_CUDA=ON \
        -D ENABLE_FAST_MATH=ON \
        -D CUDA_FAST_MATH=ON \
        -D WITH_CUBLAS=ON \
        -D WITH_NVCUVID=OFF \
        -D OPENCV_DNN_CUDA=ON \
        -D BUILD_opencv_cudaimgproc=OFF \
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
