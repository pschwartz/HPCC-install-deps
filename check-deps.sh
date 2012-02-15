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
	cmd="rpm -qa"
else
	cmd="dpkg --list"
fi

for i in `cat $file`;
do
	$cmd | grep $i > /dev/null
	if [ $? != 0 ];
	then
		echo "$i is not Installed."
	else
		echo "$i is Installed."
	fi
done
