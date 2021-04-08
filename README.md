# flutter-ci-docker-image

Docker image for flutter used in CI where aws-cli, nodejs or other binaries are required

## How to use

A example of pipeline config is below.

```yml
image: shahzaibsheikh/ci-flutter:latest

pipelines:
  branches:
    master:
      - step:
          name: Build Web
          deployment: production
          artifacts:
            - build/**
          script:
            - flutter pub get
            - flutter build web --release --web-renderer=html
```

## Rebuild image

```sh
$ docker build \
    -t shahzaibsheikh/ci-flutter:latest .
```


Forked from https://github.com/shahzaib-sheikh/ci-essentials-docker-image