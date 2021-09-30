#!/usr/bin/env sh

for l in lambda; do
    cd $l || exit 1
    GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main main.go
    zip ../artefacts/$l.zip main
    rm main
    cd ../
done;