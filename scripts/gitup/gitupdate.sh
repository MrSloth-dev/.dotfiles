#!/usr/bin/env bash

set -euo pipefail 

REPO_FILE="gitupdate.txt"
LOG_DIR="${PWD}/logs"
LOG_FILE="${LOG_DIR}"/repo_updates.log
ERROR_LOG="${LOG_DIR}"/error.log

setup_loggin() {
    mkdir -p ${LOG_DIR}
    touch ${LOG_FILE}
    touch ${ERROR_LOG}
}

setup_loggin

log_info() {
    local message="[INFO] $(date '+%Y-%m-%d-%H:%M:%S' ) - $1"
    echo -e "$message" >> ${LOG_FILE}
}

log_error() {
    local message="[ERROR] $(date '+%Y-%m-%d-%H:%M:%S' ) - $1"
    echo -e "${message}" >> ${ERROR_LOG}
    echo -e "${message}" >> ${LOG_FILE}
}

log_warning() {
    local message="[WARNING] $(date '+%Y-%m-%d-%H:%M:%S' ) - $1"
    echo "${message}" >> ${LOG_FILE}
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

git_log() {
    git_cmd=$1
    output=$(eval "${git_cmd}" 2>&1)
    exit_code=$?
    if [[ exit_code -ne 0 ]]; then
        if [[ -n $output ]]; then
            log_error $output
        fi
    else
        if [[ -n $output ]]; then
            log_info $output
        fi
    fi
}

update_repo() {
    local REPO_PATH="${1/#\~/$HOME}"
    local REPO_NAME=$(basename "${REPO_PATH}")
    log_info "Starting Process for repository: "${REPO_NAME};
    output=$(git status)
    if [[ "${output}" =~ "fatal"  ]]; then
        log_error "$REPO_PATH is not a repository" ;
        log_error "$REPO_PATH is not a repository" ;
        return 1;
    fi
    if [[ ! -d "${REPO_PATH}"  ]]; then
        log_error "No Repo Path found";
    fi

    cd $REPO_PATH
    if [[ ! $? ]]; then
        return 1
    fi

    git_log "git pull"
    if [[ -n $(git status) ]]; then
        log_info "Changes found, add and commit everything";
        git_log "git add -A"
        git_log "git commit -m 'Automatic Update'"
        git_log "git push"
        log_info "Repository ${REPO_PATH} updated"
    else
        log_warning "Changes not found, skipping to the next";
    fi
    cd - || return 0;
}

log_info "======= Starting repository update ======="
while IFS= read -r repo_path; do
    [[ -z "${repo_path}" || "${repo_path}" =~ ^#.*$ ]] && continue;
    update_repo "${repo_path}"
    log_info "---------------------------"
done < "${REPO_FILE}"
log_info "All repositories updated"
