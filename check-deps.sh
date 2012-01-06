#!/bin/bash

. deps-common

cfg.parser "deps.conf"
unset IFS

os=${1:-centos}
ver=${2:-5.5}
dev=${3:-}

if [ "$dev" == "" ];
then
	deps_line=${os}_$ver
else
	deps_line=${os}_${ver}_dev
fi

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
