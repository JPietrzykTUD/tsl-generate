#!/bin/sh -l

PARAM_TARGETS=$1
OUT_BASE=$2
LOG_BASE=$3

TARGETS=$(echo $PARAM_TARGETS | sed 's/\[//g' | sed 's/\]//g' | sed 's/ //g')
TARGETS_NAME=$(echo $TARGETS | sed 's/ /_/g' | sed 's/;/_/g')

REPO_ROOT=/github/workspace

GENERATION_PATH=${REPO_ROOT}/${OUT_BASE}/${TARGETS_NAME}
LOG_PATH=${REPO_ROOT}/${LOG_BASE}

mkdir -p ${GENERATION_PATH}
mkdir -p ${LOG_PATH}

python3 ${REPO_ROOT}/main.py --targets $TARGETS --out ${GENERATION_PATH} >${LOG_PATH}/generation_${TARGETS_NAME}.log 2>&1
if [ $? -ne 0 ]; then
  echo "msg=\"Could not generate TSL (see ${LOG_PATH}/generation.log)\"" >> $GITHUB_OUTPUT
  echo "success=0" >> $GITHUB_OUTPUT
  exit
fi

echo "msg=\"TSL can be generated (with $TARGETS), build (with $PARAM_COMPILERS) and successfully executed.\"" >> $GITHUB_OUTPUT
echo "success=1" >> $GITHUB_OUTPUT