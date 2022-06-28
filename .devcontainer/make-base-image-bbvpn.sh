#!/bin/bash

die() {
    echo "ERROR: $*" >&2
    exit 1
}

baseName="artprod.dev.bloomberg.com/rhel7-dpkg-node"
tgtName=react-devimage

docker pull ${baseName}:latest || die

xhash=$(docker images | grep -E '.*dpkg-node.*latest' | awk '{print $3}');
[[ -n $xhash ]] || die "Can't find hash for latest ${baseName}"

Dockerfile() {
    cat <<-EOF
FROM ${xhash}
RUN yum update && yum install -y sudo locales
ENV http_proxy=http://proxy.bloomberg.com:81 \
    https_proxy=http://proxy.bloomberg.com:81 \
    no_proxy=.bloomberg.com,10.0.0.0/8,100.0.0.0/8 \
    NODE_EXTRA_CA_CERTS=/etc/pki/ca-trust/source/anchors/bloomberg_rootca_v2.crt
RUN yum install -y dpkg
EOF
}

Dockerfile > tmp.dockerfile || die 101
[[ -f ./tmp.dockerfile ]] || die 102
docker build -t ${tgtName} -f tmp.dockerfile $PWD || die "Failed to build ${tgtName}"

rm tmp.dockerfile

echo "${tgtName} tag created OK"
