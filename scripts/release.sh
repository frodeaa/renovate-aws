#!/usr/bin/env sh

set -e

release_cf_template() {
    TEMPLATE_PATH=$1
    VERSION=$2

    aws s3 cp "${TEMPLATE_PATH}" "s3://renovate-aws/cf-template/${VERSION}/renovate.yml"
    aws s3 cp "${TEMPLATE_PATH}" "s3://renovate-aws/cf-template/LATEST/renovate.yml"
}

TEMPLATE=$(git rev-parse --show-toplevel)/cloudformation/renovate.yml
VERSION="$(git rev-parse --short HEAD)"
release_cf_template "${TEMPLATE}" "${VERSION}"