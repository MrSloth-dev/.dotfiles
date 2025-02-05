#!/usr/bin/env bash

set -e

REPO_FILE="gitupdate.txt"
LOG_DIR="logs"
LOG_FILE="${LOG_DIR}"/repo_updates_$(date +%Y%m%d_%H%M%S).log
ERROR_LOG="${LOG_DIR}"/errors_$(date +%Y%m%d_%H%M%S).log

setup_loggin() {
    mkir -p "${LOG_DIR}"   
    touch "${LOG_FILE}"
    touch "${ERROR_LOG}"
}

log_info() {
    local message="[INFO] $(date %Y%m%d_%H%M%S) - $1"
    echo "$message" | tee -a ${LOG_FILE}
}

log_error() {
    local message="[ERROR] $(date %Y%m%d_%H%M%S) - $1"
    echo "${message}" | tee -a ${ERROR_LOG}
    echo "${message}" >> ${LOG_FILE}
}

log_warning() {
    local message="[WARNING] $(date %Y%m%d_%H%M%S) - $1"
    echo "${message}" | tee -a ${LOG_FILE}
}

execute_cmd() {
    local cmd=$1
    local error_msg=$2


    output=$($cmd 2>&1)
    exit_status=$?

    if [ $exit_status -ne 0 ]; then
        log_error "$error_msg"
        log_error "Command: $cmd"
        log_error "Output: $output"
        return 1;
    else
        log_info "$cmd completed successfully"
        [ -n "${output}" ] && log_info "Output: $output"
        return 0;
    fi
}


if [[ ! -f "${REPO_FILE}" ]]; then
    log_error "Repository list file "${REPO_FILE}" not found!"
    exit 1
fi


update_repo() {
    local REPO_PATH="$1"
    local REPO_NAME=$(basename "${REPO_PATH}")
    log_info "Starting Process for repository: "${REPO_NAME};
    output=$(git status)
    if [[ "${output}" =~ "fatal"  ]]; then
        log_error 
        echo -e "$REPO_PATH is not a repository";
        return 1;
    fi
    if [[ ! -d "${REPO_PATH}"  ]]; then
        echo -e "No Repo Path found";
    fi

    cd "$REPO_PATH" || return 1
    git pull
    if [[ -n $(git status) ]]; then
        echo -e "Changes found, add and commit everything";
        git add -A
        git commit -m "Automatic Update"
        git push
        echo -e "Repository ${REPO_PATH} updated"
    else
        echo -e "Changes not found, skipping to the next";
    fi

    cd - >/dev/null/
}


echo -e "Starting repository update"
while IFS= read -r repo_path; do
    [[ -z "${repo_path}" || "${repo_path}" =~ ^#.*$ ]] && continue;
    update_repo "${repo_path}"
    echo -e "---------------------------"
done < "${REPO_FILE}"


echo -e "All repositories updated"
