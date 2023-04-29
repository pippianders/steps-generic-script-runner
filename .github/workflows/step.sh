#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONFIG_tmp_script_file_path="${THIS_SCRIPT_DIR}/._script_cont"

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
	if [ $? -ne 0 ] ; then
		echo " [!] Failed to switch to working directory: ${GENERIC_SCRIPT_RUNNER_WORKING_DIR}"
		exit 1
	fi
fi

if [ ! -z "${GENERIC_SCRIPT_RUNNER_SCRIPT_TMP_PATH}" ] ; then
	echo "==> Script (tmp) save path specified: ${GENERIC_SCRIPT_RUNNER_SCRIPT_TMP_PATH}"
	CONFIG_tmp_script_file_path="${GENERIC_SCRIPT_RUNNER_SCRIPT_TMP_PATH}"
fi

printf "${GENERIC_SCRIPT_RUNNER_CONTENT}" > "${CONFIG_tmp_script_file_path}"

echo
${GENERIC_SCRIPT_RUNNER_BIN} "${CONFIG_tmp_script_file_path}"
script_result=$?

echo
echo "==> Script finished with exit code: ${script_result}"

rm "${CONFIG_tmp_script_file_path}"
exit ${script_result}
