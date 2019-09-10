#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
$DIR/build.sh -n

docker run -d mmerian/postfix-mysql:latest
docker ps|grep 'mmerian/postfix-mysql:latest'
exit $?
