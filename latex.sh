#!/bin/bash

usage() {
    echo "Usage:"
    echo "$0 --help|-h"
    echo "  Print this help message."
    echo ""
    echo "$0 [-f|--fast] [-j|--jobname <jobname>] [-d|--build-dir <dir>=build] <texfile>"
    exit 1
}

create_dir() {
    if [ ! -d ${BUILDDIR} ]; then
        mkdir ${BUILDDIR}
    fi
}

run_latex() {
    echo "${LATEX_CMD}"
    if ! eval ${LATEX_CMD} > /dev/null ; then
        exit 2
    fi
}

run_biber() {
    echo "${BIBER_CMD}"
    eval ${BIBER_CMD} | grep -E "^(WARN|ERROR)"
    if ! [ "${PIPESTATUS[0]}" -eq 0 ] ; then
        error
    fi
}

fast() {
    create_dir
    run_latex
}

full() {
    create_dir
    run_latex
    run_latex
}

if [ "$#" -eq 0 ]; then
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
    JOBNAME=$(basename "${FILE%.tex}")
fi

if [ -z "${BUILDDIR}" ]; then
    BUILDDIR="build"
fi

if [ -z "${FAST}" ]; then
    FAST=false
fi

SCRIPT_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
LATEX_ENV="TEXINPUTS=\"${SCRIPT_DIR}:${TEXINPUTS}\""
LATEX_ARG="--shell-escape --halt-on-error --interaction=batchmode --output-directory=\"${BUILDDIR}/\" --jobname=\"${JOBNAME}\" \"${FILE}\""
LATEX_CMD="env ${LATEX_ENV} lualatex ${LATEX_ARG}"
BIBER_ARG="--logfile \"${BUILDDIR}/${JOBNAME}.blg\" --outfile \"${BUILDDIR}/${JOBNAME}.bbl\" \"${BUILDDIR}/${JOBNAME}.bcf\""
BIBER_CMD="env biber${BIBER_ARG}"

if "${FAST}" ; then
    fast
else
    full
fi
