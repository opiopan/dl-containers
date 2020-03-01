run(){
    
    docker run --gpus all -it --rm --net host --name dlenv \
       -e DISPLAY=$DISPLAY -v $HOME/dnn-data:$HOME  \
       -v $HOME/.Xauthority:$HOME/.Xauthority  \
       -e LOCAL_USER=$USER -e LOCAL_UID=`id -u $USER` \
       -e LOCAL_GID=`id -g $USER` \
       opiopan/dlenv:$DLENV_TAG $*
}
