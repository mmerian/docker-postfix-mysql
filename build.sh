#!/bin/bash

BUILD_OPTIONS=''
TAG_VERSION='no'
PUSH_TAG='no'
IMAGE_NAME=mmerian/postfix-mysql

while getopts "ntp" option; do
    case $option in
        n)
            BUILD_OPTIONS='--no-cache'
        ;;
        t)
            TAG_VERSION='yes'
        ;;
        p)
            PUSH_TAG='yes'
        ;;
    esac
done

docker pull mmerian/postfix

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
docker build $DIR -t ${IMAGE_NAME}:latest $BUILD_OPTIONS

if [ "$TAG_VERSION" == "yes" ]; then
    # Get version number, in order to create tag
    IMAGE_VER=`docker run ${IMAGE_NAME}:latest postconf -h mail_version`
    echo "Tagging version $IMAGE_VER"
    docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:$IMAGE_VER
    if [ "$PUSH_TAG" == "yes" ]; then
        echo "Pushing tag latest"
        docker push "${IMAGE_NAME}:latest"
        echo "Pushing tag $IMAGE_VER"
        docker push "${IMAGE_NAME}:$IMAGE_VER"
    fi
fi
