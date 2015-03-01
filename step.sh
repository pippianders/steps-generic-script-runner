#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONFIG_tmp_script_file_path="${THIS_SCRIPT_DIR}/._script_cont"

set -e

if [ -z "${GENERIC_SCRIPT_RUNNER_CONTENT}" ] ; then
	echo " [!] => Failed: No script (content) defined for execution!"
	exit 1
fi

if [ -z "${GENERIC_SCRIPT_RUNNER_BIN}" ] ; then
	echo " [!] => Failed: No script executor defined!"
	exit 1
fi

echo
echo "==> Start"

if [ ! -z "${GENERIC_SCRIPT_RUNNER_WORKING_DIR}" ] ; then
	echo "==> Switching to working directory: ${GENERIC_SCRIPT_RUNNER_WORKING_DIR}"
	cd "${GENERIC_SCRIPT_RUNNER_WORKING_DIR}"
fi

echo "${GENERIC_SCRIPT_RUNNER_CONTENT}" > "${CONFIG_tmp_script_file_path}"

set +e
${GENERIC_SCRIPT_RUNNER_BIN} "${CONFIG_tmp_script_file_path}"
script_result=$?
set -e

rm "${CONFIG_tmp_script_file_path}"
exit ${script_result}