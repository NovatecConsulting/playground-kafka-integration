#!/usr/bin/env bash
BASE_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"
source "${BASE_DIR}/../.env"

CONFLUENT_VERSION=${CONFLUENT_VERSION:-7.0.0}
REGISTRY=${REGISTRY:-}
IMAGE=${IMAGE:-integration-integrations-kafka-connect-standalone}
TAG=${TAG:-${CONFLUENT_VERSION}}

function fullImageName () {
    if [ -n "${REGISTRY}" ]; then
        echo ${REGISTRY}/${IMAGE}:${TAG}
    else
        echo ${IMAGE}:${TAG}
    fi
}

docker build -t $(fullImageName) --build-arg "CONFLUENT_VERSION=${CONFLUENT_VERSION}" "${BASE_DIR}"