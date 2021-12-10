#!/usr/bin/env bash
set -e
ENV_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"
source "${ENV_DIR}/.env"

function fail () {
    log "ERROR" "$1"
    exit 1
}

function log () {
    local level="${1:?Requires log level as first parameter!}"
    local msg="${2:?Requires message as second parameter!}"
    echo -e "$(date --iso-8601=seconds)|${level}|${msg}"
}

function create_docker_network_if_not_exists () {
    local name="${1:?Requires name as first parameter!}"
    if ! $(docker network inspect "${name}" > /dev/null 2>&1); then
        docker network create --attachable -d bridge "${name}" > /dev/null
        log "INFO" "Created Docker network '${name}'"
    fi
}

function remove_docker_network_if_exists () {
    local name="${1:?Requires name as first parameter!}"
    if $(docker network inspect "${name}" > /dev/null 2>&1); then
        docker network rm "${name}" > /dev/null 2>&1
    fi
}

function dc_in_env () {
    local env=${1:?Missing env as first parameter!}
    shift
    local project_dir="${ENV_DIR}/${env}"
    if [ ! -e "${project_dir}/docker-compose.yaml" ]; then
        fail "\"${env}\" is not a docker compose environment!"
    fi
    if [ "${1}" == "up" ]; then
        create_docker_network_if_not_exists "${DOMAIN_NAME}"
    fi
    docker compose \
        --env-file "${ENV_DIR}/.env" \
        --project-directory "${project_dir}" \
        "$@"
    if [ "${1}" == "down" ]; then
        remove_docker_network_if_exists "${DOMAIN_NAME}"
    fi
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
   dc_in_env "$@"
fi