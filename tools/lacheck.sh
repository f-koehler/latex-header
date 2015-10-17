#!/bin/bash

while test $# -gt 0; do
    echo "lacheck $1"
    lacheck $1
    shift
done
