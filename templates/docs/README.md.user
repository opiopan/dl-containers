dlenv
====

dlenv is a container image that contains several midleware for deel learning.<br>
Dockerfile for this image is automaticaly generated from a template file and a rulefile. Refer [this github repository](https://github.com/opiopan/dl-containers) for details.

## Tag Naming Convention
There are many tools and midlewares for deep learning in the workld, and they are updated without backword compatibility sometimes.
This is the major motivation to use container for deep learning environment.<br>
dlenv-utils provides several variation of images as combination of some version of each tool and midleware.
Tag name of each image is very long since tag indicates version of each tool and midleware.<br>
In this section, naming rule for tag is explained.

Tags are roughly divided into two types as below examples.
One is a image composed of CUDA based tools that is starting with '```cX.X-```'. The other one is a image composed of CPU based tools that is starting with '```cpu-```'.<br>

```
# Composed of CUDA based tools
c10.0-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc4.2.0

# Composed of CPU based tools
cpu-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc4.2.0
```

Tag name is consit of several parts separated by '```-```' as below.<br>

Part      |Remarks
----------|-------------------
cX.X      | [CUDA](https://hub.docker.com/r/nvidia/cuda) version
pyX.X.X   | [python](https://www.python.org) version
tfX.XX.X  | [TensorFlow](https://www.tensorflow.org) version
chX.X.X   | [Chainer](https://chainer.org) version
trX.X.X   | [PyTorch](https://pytorch.org) version
ocX.X.X   | [OpenCV](https://opencv.org) version

## Running container
[dl-containers](https://github.com/opiopan/dl-containers) provides useful tool to run this image.
I strongly recomend use this tool instead of ```docker``` command or docker-compose.

If you run this image directly using ```docker``` command, a couple of environment variable are specified. Following is a example to run container.

```
docker run --gpus all -it --rm --net host \
       -e DISPLAY=$DISPLAY \
       -v HOSTDIR:/home/USERNAME \
       -v $HOME/.Xauthority:/home/USERNAME/.Xauthority \
       -e LOCAL_USER=USERNAME -e LOCAL_UID=`id -u USERNAME` \
       -e LOCAL_GID=`id -g USERNAME` \
       opiopan/dlenv:TAGNAME
```