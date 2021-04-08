# flutter-ci-docker-image

Docker image for flutter used in CI where aws-cli, nodejs or other binaries are required

## How to use

A example of pipeline config is below.

```yml
image: shahzaibsheikh/ci-essentials:latest

pipelines:
  branches:
    master:
      - step:
          name: Build Web
          deployment: production
          caches:
            - node
          script:
            - node --version
            - aws --version
            - npm i
            - npm run build
            - aws s3 sync --delete --exclude "bitbucket-pipelines.yml" . s3://example-bucket
```

## Rebuild image

```sh
$ docker build \
    --build-arg AWS_CLI_VERSION=1.16.98 \
    -t shahzaibsheikh/ci-essentials:latest:1.16.98 .
```


Forked from https://github.com/TakuroFukamizu/atlassian-pipeline-awscli-node