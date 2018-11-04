#!/usr/bin/env sh

set -e

bucket="${RENOVATE_BUCKET:-renovate-aws}"
root="$(git rev-parse --show-toplevel)"

release_cf_template() {
    TEMPLATE_PATH=$1
    VERSION=$2

    aws s3 cp "${TEMPLATE_PATH}" "s3://${bucket}/cf-template/${VERSION}/renovate.yml"
    aws s3 cp "${TEMPLATE_PATH}" "s3://${bucket}/cf-template/latest/renovate.yml"
}

release_config() {
    CONFIG=$1
    VERSION=$2

    TMPDIR=$(mktemp -d)
    zip -r --junk-paths "${TMPDIR}/config" "${CONFIG}"

    aws s3 cp "${TMPDIR}/config.zip" "s3://${bucket}/config/${VERSION}/config.zip"
    aws s3 cp "${TMPDIR}/config.zip" "s3://${bucket}/config/latest/config.zip"
}

TEMPLATE="${root}/cloudformation/renovate.yml"
CONFIG="${root}/config"
VERSION="$(git rev-parse --short HEAD)"

release_cf_template "${TEMPLATE}" "${VERSION}"
release_config "${CONFIG}" "${VERSION}"
