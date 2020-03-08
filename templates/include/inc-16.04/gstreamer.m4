ARG GSTREAMER_VERSION="__GSTREAMER_VERSION__"

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
