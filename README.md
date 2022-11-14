# GROWI Local Extension

Spin up cloud environment locally for [GROWI](https://github.com/weseek/growi).

- AWS S3
- GCP GCS


## Requirements

- [docker](https://docs.docker.com/get-docker/)
- [terraform cli](https://developer.hashicorp.com/terraform/downloads)
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

For homebrew users,

```sh
brew install docker awscli terraform
```


## Getting Started

### AWS

```sh
# init
docker compose -f aws/docker-compose.yml up -d
terraform -chdir=aws init
terraform -chdir=aws apply -auto-approve

# upload file
aws s3 cp README.md s3://growi --endpoint-url=http://localhost:4566

# list buckets
aws s3 ls --endpoint-url=http://localhost:4566

# list files
aws s3 ls --endpoint-url=http://localhost:4566 growi --recursive

# deinit
terraform -chdir=aws destroy -auto-approve
```

### GCP

```sh
# create
docker compose -f gcp/docker-compose.yml up -d
terraform -chdir=gcp init
terraform -chdir=gcp apply -auto-approve

# destory
terraform -chdir=aws destroy
```
