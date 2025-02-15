#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

./build.sh

docker volume create l2rtest-output

docker run --rm \
        --memory=4g \
        -v $SCRIPTPATH/test/:/input/ \
        -v l2rtest-output:/output/ \
        l2rtest

docker run --rm \
        -v l2rtest-output:/output/ \
        python:3.7-slim cat /output/metrics.json | python -m json.tool

docker volume rm l2rtest-output
