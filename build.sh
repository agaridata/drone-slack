#!/bin/bash
set -e

TAGNAME="latest"

# Make sure go compiler is installed
if ! hash go 2>/dev/null; then
    echo "Go is not installed. Please run 'brew install go' and try again."
    exit 1
fi

# Install/update dependencies
echo "Updating dependencies"
go get -u .

# Build
echo "Building..."
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -a -tags netgo -o release/linux/amd64/drone-slack
docker build --rm -t quay.io/agari/drone-slack:$TAGNAME .
docker push quay.io/agari/drone-slack:$TAGNAME
