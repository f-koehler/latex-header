#!/bin/bash

usage() {
    echo "Usage:"
    echo "$0 --help|-h"
    echo "  Print this help message."
    echo ""
    echo "$0 [-f|--fast] [-j|--jobname <jobname>] [-d|--build-dir <dir>=build] <texfile>"
    exit 1
}

run_latex() {
    if ! eval ${TEX_CMD} > /dev/null ; then
        exit 2
    fi
}

run_biber() {
    eval ${BIBER_CMD} | grep -E "^(WARN|ERROR)"
    if ! [ "${PIPESTATUS[0]}" -eq 0 ] ; then
        error
    fi
}

fast() {
    run_latex
}

full() {
    run_latex
}

if [ "$#" -lt 1 ]; then
    usage
fi

while [ "$#" -gt 1 ]; do
    case "$1" in
        "-h")
            usage
            ;;
        "--help")
            usage
            ;;
        "-f")
            FAST=true
            ;;
        "--fast")
            FAST=true
            ;;
        "-j")
            JOBNAME="$2"
            shift
            ;;
        "--jobname")
            JOBNAME="$2"
            shift
            ;;
        "-d")
            BUILDDIR="$2"
            shift
            ;;
        "--build-dir")
            BUILDDIR="$2"
            shift
            ;;
    esac
    shift
done

FILE="$1"

if [ -z "${JOBNAME}" ]; then
    JOBNAME="${FILE%.tex}"
fi

if [ -z "${BUILDDIR}" ]; then
    BUILDDIR="build"
fi

if [ -z "${FAST}" ]; then
    FAST=false
fi

TEX_ARG="--shell-escape --halt-on-error --interaction=batchmode --output-directory=${BUILDDIR} --jobname=\"${JOBNAME}\" \"${FILE}\""
TEX_CMD="lualatex ${TEX_ARG}"
BIBER_ARG="--logfile \"${BUILDDIR}/${JOBNAME}.blg\" --outfile \"${BUILDDIR}/${JOBNAME}.bbl\" \"${BUILDDIR}/${JOBNAME}.bcf\""
BIBER_CMD="biber"

if "${FAST}" ; then
    fast
else
    full
fi
