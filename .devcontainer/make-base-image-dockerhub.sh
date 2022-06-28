#!/bin/bash
# Create react-devimage from Dockerhub baseline
#
die() {
    echo "ERROR: $*" >&2
    exit 1
}

baseName="ubuntu"
tgtName=react-devimage

command docker pull ${baseName}  || die "Cant pull from dockerhub"

command docker tag ${baseName} ${tgtName} || die Failed tagging image

echo "${tgtName} tag created OK"

