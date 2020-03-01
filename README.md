dl-containers
====

dl-containers contains a couple of Dockerfile of containers for deep learning, a generator these Dockerfile from template and rule, and a python tool to handle these container.<br>

There are many tools and middlewares for deep learning in the workld, and they are updated without backword compatibility sometimes.
This is the major motivation to use container for deep learning environment.<br>
On the other hand, maintaing so large number of Dockerfiles for comvination of each tool's version is also painful for me.<br>
So, I made a generator of Dockerfile from a template file.


## Naming convention of tag
dl-containers provides several variation of images as combination of some version of each tool and middleware.
Tag name of each image is very long since tag indicates version of each tool and middleware.<br>
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


## Building container images
This step is not necessary since all images are published on [DockerHub](https://hub.docker.com/u/opiopan]).<br>
If you have a reason that you don't wont to pull images from DockerHub, or you geranerate a your own Dockerfile as described steps below, buid images as following steps.

### In case of buiding a specific tag
By executing ```make``` specifing target ```list```, you can know all buildable tag names.

```shell
$ make list
```

Then, execute ```make``` with tag name that you want to build.

```shell
$ make TAG-NAME
```

### In case of buiding all tags
You can also build all buildable tags at once.
In this case, specify ```allimages``` as a target.

```shell
$ make allimages
```

## Running container using helper tool
dl-containers provide a tool ```dlenv``` which is designed to help running a container.<br>
I strongly recomend you to use this tool instead using docker run command.

### Installing dlenv
```shell
$ pip install -r tools/requirements.txt
$ sudo make install
```

### Prepare configuration file
```dlenv``` refer configuration writen in ```${HOME}/.dlenv/config```.
You should specify a directory on host which is mounted at home directory on container.<br>
NOTE: You can use ```~``` as path component to indicate a home directory.

```yaml
# ${HOME}/.dlenv/config
home-volume: ~/dl-data
```

### Set tag to run
```dlenv list``` command show list of excutable tags in docker repository. If ```--hub``` option is specified, executable tags are retrieved from DockerHub instead of referring local repository.<br>
You can set a default tag to run by ```dlenv settag``` command.

```shell
$ dlenv list --hub
  c10.0-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc3.4.9
  c10.0-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc4.2.0

       SNIP

$ dlenv settag c10.0-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc4.2.0
```

### Running container
```dlenv run``` command run a container. If tag name specification by ```--tag=``` option is omitted, default tag set by ```dlenv settag``` command is used.<br>

```shell
$ sudo dlenv run
```

As same as ```docker run```, command to run on a container can be specified by arguments.<br>
In case following example, Jupyter Notebook is run on a container.

```
$ sudo dlenv run jupyter notebook
```

## Adding image variation
Image variation is defined in a rule file ```templates/Instances.json```.<br>
This file expresses a JSON object contains, and each key name is corresponding to tag name of image.
An JSON object corrensponding to tag consists rules to build each middleware as below.

```json
    "c10.0-py3.6.8-tf1.13.1-ch7.1.0-tr1.2.0-oc4.2.0": {
	"type": "cuda",
	"cuda-container":{
	    "cuda-version": "10.0",
	    "cudnn-version": "7",
	    "ubuntu-version": "18.04"
	},
	"python": {"version": "3.6.8"},
	"tensorflow": {"version": "1.13.1"},
	"cupy": {
	    "package": "cupy-cuda100",
	    "version": "7.1.1"
	},
	"chainer": {"version": "7.1.0"},
	"pytorch": {
	    "version": "1.2.0",
	    "whl-list": "https://download.pytorch.org/whl/torch_stable.html"
	},
	"torchvision": {"version": "0.4.0"},
	"pillow": {"version": "6.2.1"},
	"opencv":{
	    "version": "4.2.0",
	    "options": "-DCUDA_ARCH_BIN='6.0 6.1 7.0 7.5' -DCUDA_ARCH_PTX='6.0 6.1 7.0 7.5'"
	}
    },
```

If you want to add variations of images, add a entry for tags to ```templates/Instansec.json```.
After that,  make a ```dockerfiles``` target to generate Dockerfile for added tags.

```
$ make dockerfiles
```

Once Dockerfiles are generated, you can build a image as steps described above.
