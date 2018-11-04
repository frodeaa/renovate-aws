# renovate-aws

This project enables self-hosting [Renovate] on AWS.

## Configuration

The `cloudformation/renovate.yml` template supports following parameters:

Parameter            | Description   | Default |
-------------------- |:------------- | -----------: |
RenovateRepositories | comma separated list of repositories to run against   ||
RenovateVersion      | renovate version to use                        | latest|
RenovateFlags        | flags to run renovate with (see `--help` for flags)   ||
RenovatePlatform     | the platform, requires `GitHubToken` or `GitLabToken` ||
GitHubToken          | token used when platform is `github`          | NOT_SET|
GitLabToken          | token used when platform is `gitlab`          | NOT_SET|
TimeoutInMinutes     | timeout for renovate build                    | `10`   |
RenovateConfigLocation |            | `renovate-aws/config/latest/config.zip` |
|||
ComputerType| computer to to use with `renovate`| `BUILD_GENERAL1_SMALL`       |
Image       | build image used                  | `aws/codebuild/nodejs:10.1.0`|
BuildSpec   | buildspec from `RenovateConfigLocation ` | `buildspec.yml`       |

### RenovateConfigLocation

CodeBuild project requires a `source` to build. The default value of
`RenovateConfigLocation` is zip of `config` containing the `buildspec.yml` and `renovate-config.js`.
You can deploy your own copy of the template and config to your own
S3 bucket with:

    RENOVATE_BUCKET=renovate-my-bucket ./scripts/release.sh

## Installing

This project will setup an AWS CodeBuild project which will run [Renovate] on
your GitHub or GitLab repositories.

Use the [awscli] to create the stack from the `cloudformation/renovate.yml`
template or just click the "Launch Stack" button.

    aws cloudformation create-stack \
        --stack-name renovate \
        --template-body "file://$(pwd)/cloudformation/renovate.yml" \
        --parameters ...

[![Launch CloudFormation Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=renovate&templateURL=https://s3-eu-west-1.amazonaws.com/renovate-aws/cf-template/latest/renovate.yml)

[Renovate]: https://github.com/renovatebot/renovate
[awscli]: https://aws.amazon.com/cli/
