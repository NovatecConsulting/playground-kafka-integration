#!/usr/bin/env bash

REGISTRY=${REGISTRY:-}
IMAGE=${IMAGE:-integration-app-httpserver}
TAG=${TAG:-latest}

function fullImageName () {
    if [ -n "${REGISTRY}" ]; then
        echo ${REGISTRY}/${IMAGE}:${TAG}
    else
        echo ${IMAGE}:${TAG}
    fi
}

docker build -t $(fullImageName) .