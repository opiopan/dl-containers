ARG BASECONTAINER="opiopan/dlenv-utils:c10.0-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc3.4.9"

FROM ${BASECONTAINER}
LABEL maintainer "opiopan@gmail.com"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gosu sudo && \
    apt-get clean

RUN grep -v secure_path /etc/sudoers > /etc/sudoers.new && \
    echo 'Defaults env_keep += "PATH"' >> /etc/sudoers.new && \
    echo 'Defaults env_keep += "PYENV_ROOT"' >> /etc/sudoers.new && \
    mv /etc/sudoers.new /etc/sudoers

COPY entrypoint /boot/entrypoint
RUN chmod +x /boot/entrypoint

RUN echo "    Ubuntu      : "$(grep VERSION_ID /etc/os-release | cut -d'"' -f2) >> /boot/version;\
    if [ x"$CUDA_VERSION" != x ];then \
	echo "    CUDA        : $CUDA_VERSION" >>/boot/version;\
	echo "    cuDNN       : $CUDNN_VERSION" >> /boot/version;\
    fi;\
    echo "    Python      : $(pyenv version | cut -d' ' -f1)" >> /boot/version;\
    echo "    TensorFlow  : "$(echo ==1.13.1 | sed -e 's/=//g') >>/boot/version;\
    echo "    Chainer     : "$(python -c 'import chainer; print(chainer.__version__)') >>/boot/version;\
    echo "    PyTorch     : "$(python -c 'import torch; print(torch.__version__)') >>/boot/version;\
    echo "    TorchVision : "$(python -c 'import torchvision; print(torchvision.__version__)') >>/boot/version;\
    if type gst-inspect-1.0; then echo "    GStreamer   : "$(gst-inspect-1.0 --version | grep GStreamer | cut -d' ' -f2) >>/boot/version; fi;\
    echo "    OpenCV      : "$(opencv_version) >>/boot/version

ENTRYPOINT ["/boot/entrypoint"]
