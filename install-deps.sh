#!/bin/bash


. deps-common

cfg.parser "deps.conf"
unset IFS

os=${1:-centos}
ver=${2:-5.5}
dev=${3:-}

deps_line=${os}_$ver

cfg.section.${deps_line}

if [ "$os" == "centos" ];
then
        cmd="yum install -y -q"
else
        cmd="apt-get install -y"
fi

for i in `cat $file`;
do
        $cmd $i
done

if [ "$add_file" != "" ];
then
	./$add_file
fi
