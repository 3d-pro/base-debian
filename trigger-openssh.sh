#!/bin/bash

TRAVIS_TOKEN=$1

curl -s -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Travis-API-Version: 3' -H 'Authorization: token $TRAVIS_TOKEN' -d '"request": {"branch": "master"}'  https://api.travis-ci.org/repo/3d-pro%2Fopenssh/requests
