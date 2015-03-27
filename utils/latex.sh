#!/bin/bash

TEX_ARG="--shell-escape --halt-on-error --interaction=batchmode --output-directory=build"
TEX_CMD="lualatex ${TEX_ARG}"

while [ "$#" -gt 1 ] ; do
    case "$1" in
        "--fast")
            FAST=true
            ;;
        "--jobname")
            JOBNAME="$2"
            shift
            ;;
    esac
    shift
done
