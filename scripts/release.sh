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

TEMPLATE="${root}/cloudformation/renovate.yml"
VERSION="$(git rev-parse --short HEAD)"
release_cf_template "${TEMPLATE}" "${VERSION}"
