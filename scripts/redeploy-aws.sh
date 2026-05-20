#!/bin/sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
INFRA_DIR="$(dirname "$SCRIPT_DIR")"

cd "$INFRA_DIR"

docker build -t eeg-infra-eeg-be ../eeg-be
docker build -f ../eeg-fe/Dockerfile.aws -t eeg-infra-eeg-fe ../eeg-fe
docker build -t eeg-infra-eeg-ml-pipeline ../eeg-ml-pipeline

docker compose -f docker-compose.aws.yml up -d --no-build
