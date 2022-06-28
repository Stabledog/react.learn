#!/bin/bash
# Create react-devimage from Dockerhub baseline
#
die() {
    echo "ERROR: $*" >&2
    exit 1
}

baseName="ubuntu"
tgtName=react-devimage

command docker pull ${baseName}  || die "Cant pull image"

xhash=$(docker images | grep -E '.*ubuntu.*latest' | awk '{print $3}');
[[ -n $xhash ]] || die "Can't find hash for latest ${baseName}"

Dockerfile() {
    cat <<-EOF
FROM ${xhash}
RUN apt-get update && apt-get install -y sudo locales
RUN locale-gen en_US.UTF-8

EOF
}


Dockerfile > tmp.dockerfile || die 101
[[ -f ./tmp.dockerfile ]] || die 102
docker build -t ${tgtName} -f tmp.dockerfile $PWD || die "Failed to build ${tgtName}"

rm tmp.dockerfile

echo "${tgtName} tag created OK"

