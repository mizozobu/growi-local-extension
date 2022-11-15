# GROWI Local Extension

Spin up cloud environment locally for [GROWI](https://github.com/weseek/growi).

- AWS S3
- GCP GCS


## Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Google Cloud CLI](https://cloud.google.com/sdk/docs/install-sdk)


## Getting Started

### AWS

```sh
# init
docker compose -f aws/docker-compose.yml up -d

# create bucket
terraform -chdir=aws init
terraform -chdir=aws apply -auto-approve

# upload file
aws s3 cp README.md s3://growi --endpoint-url=http://localhost:4566

# list buckets
aws s3 ls --endpoint-url=http://localhost:4566

# list files
aws s3 ls --endpoint-url=http://localhost:4566 growi --recursive

# delete bucket
terraform -chdir=aws destroy -auto-approve
```

### GCP

```sh
# init
docker compose -f gcp/docker-compose.yml up -d
gcloud config configurations create growi
gcloud config set project growi
gcloud config set api_endpoint_overrides/storage http://localhost:4443/storage/v1/

# create bucket
terraform -chdir=gcp init
terraform -chdir=gcp apply -auto-approve

# upload file
curl -X POST 'http://localhost:4443/upload/storage/v1/b/growi/o?uploadType=media&name=README.md' --data-binary @README.md
# somehow this gives: HTTPError 400: invalid Content-Type header
# gcloud storage cp README.md gs://growi --access-token-file=gcp/token.txt

# list buckets
gcloud storage ls --access-token-file=gcp/token.txt

# list files
gcloud storage ls gs://growi --access-token-file=gcp/token.txt

# delete bucket
terraform -chdir=gcp destroy -auto-approve
```
