#!/bin/bash

# Determine which python command to use depending on platform 
unameOut="$(uname -s)"
case "${unameOut}" in
    MINGW*)     py=py;;
    *)          py=python3;;
esac

if [ $# -ne 2 ]
then
    echo "Usage: $0 <preprocessed data dir> <num gpus used>" 
    exit -1
fi

datadir=$1
num_gpus=$2
expname=$(basename $1)
# extrace 'data/' since we'll be moving into it
datadir_relative=${datadir#data/}

pushd data
./preprocess_traces.sh $datadir_relative $num_gpus
popd
${py} timeline.py $datadir $expname