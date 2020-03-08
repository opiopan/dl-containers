ARG BASECONTAINER="ubuntu:16.04"

FROM ${BASECONTAINER}
LABEL maintainer "opiopan@gmail.com"

ARG PYTHON_VERSION="3.6.8"
ARG NUMPY_VERSION="==1.16.6"
ARG TF_VERSION="==1.8.0"
ARG CHAINER_VERSION="==6.6.0"
ARG PYTORCH_VERSION="==1.0.0"
ARG TORCHVISION_VERSION="==0.2.1"
ARG PYTORCH_WHLLIST="https://download.pytorch.org/whl/cu90/torch_stable.html"
ARG PILLOW_VERSION="==6.2.1"

#-----------------------------------------------------
# install essentials
#-----------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata && \
    apt-get install -y --no-install-recommends \
    	curl \
	git \
	build-essential \
	ca-certificates \
	libffi-dev \
	libssl-dev \
	zlib1g-dev \
	liblzma-dev \
	libbz2-dev libreadline-dev libsqlite3-dev \
	tk-dev
ENV DEBIAN_FRONTEND=

#-----------------------------------------------------
# install Python
#-----------------------------------------------------
RUN apt-get purge -y python* libpython* && \
    git clone --depth=1 git://github.com/pyenv/pyenv.git .pyenv
WORKDIR /
ENV HOME  /
ENV PYENV_ROOT /.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION} && \
    pyenv rehash && \
    pip install --no-cache-dir --upgrade pip &&\
    pip install --no-cache-dir setuptools

#-----------------------------------------------------
# install Tensorfolow & Keras
#-----------------------------------------------------
RUN pip install --no-cache-dir \
    numpy${NUMPY_VERSION} \
    tensorflow${TF_VERSION} \
    keras

#-----------------------------------------------------
# install Chainer
#-----------------------------------------------------
RUN pip install --no-cache-dir chainer${CHAINER_VERSION}

#-----------------------------------------------------
# install PyTorch
#-----------------------------------------------------
RUN pip install --no-cache-dir Pillow${PILLOW_VERSION} && \
    pip install --no-cache-dir -f ${PYTORCH_WHLLIST} \
    	torch${PYTORCH_VERSION} \
    	torchvision${TORCHVISION_VERSION}

#-----------------------------------------------------
# install essential python libs for ML
#-----------------------------------------------------
ARG MATPLOTLIB_VERSION="==3.1.3"
RUN pip install --no-cache-dir \
    	Pillow \
	matplotlib${MATPLOTLIB_VERSION} \
	tqdm \
	h5py \
	kaggle-cli \
	gym

#-----------------------------------------------------
# clean up
#-----------------------------------------------------
RUN apt-get clean
