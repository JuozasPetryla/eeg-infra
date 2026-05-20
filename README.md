# Psich.ai

## Prerequisites

- Git
- WSL (if on windows)
- Python 3.1x
- Docker desktop

## Setup

All repos should be cloned in the the same directory:

```
root_repos_dir/
    eeg-be/
    eeg-fe/
    eeg-infra/
    eeg-ml-pipeline/
```

Create the root repo directory and inside it run:

- `git clone https://github.com/JuozasPetryla/eeg-be.git`
- `git clone https://github.com/JuozasPetryla/eeg-fe.git`
- `git clone https://github.com/JuozasPetryla/eeg-infra.git`
- `git clone https://github.com/JuozasPetryla/eeg-ml-pipeline.git`

Ensure docker desktop is running

Run the following commands:

- `cd eeg-infra/`
- `docker compose up --build -d`

To run backend tests in an isolated container:

- `docker compose run --rm eeg-be-test`

To run backend integration tests against real Postgres and MinIO:

- `docker compose run --rm eeg-be-integration-test`

This uses a dedicated `postgres-integration` database and a separate MinIO bucket so it does not reset your normal local backend data.

Now everything should be up and running locally

## Usage

Refer to usage of each service in their invidual repo readme.md.

- BE - https://github.com/JuozasPetryla/eeg-be
- FE - https://github.com/JuozasPetryla/eeg-fe
- ML-pipeline - https://github.com/JuozasPetryla/eeg-ml-pipeline

## AWS Lightsail

The simplest AWS deployment in this repo is a single Lightsail VM managed by CloudFormation:

- Template: `aws/lightsail-single-node.yaml`
- Runtime compose file: `docker-compose.aws.yml`

This setup is intentionally optimized for simplicity and low cost:

- one Lightsail Linux instance
- Docker installed by instance launch script
- repos cloned directly from GitHub on first boot
- frontend exposed on port `80`
- backend kept private by default and reverse-proxied through the frontend container
- Postgres and MinIO stay internal to the VM

### Deploy

From `eeg-infra/`:

```bash
aws cloudformation deploy \
  --region us-east-1 \
  --stack-name psich-ai-dev \
  --template-file aws/lightsail-single-node.yaml \
  --parameter-overrides \
    ProjectName=psich-ai-dev \
    GitHubOwner=JuozasPetryla \
    GitBranch=main \
    BundleId=small_3_0 \
    CreateStaticIp=true \
    ExposeApiPort=false \
    CreateBucket=false
```

Recommended bundle:

- `small_3_0` for the best simplicity/cost balance for a short-lived tester deployment

Cheaper but riskier:

- `micro_3_0` if you only need very light short-lived testing

Safer upgrade if the ML pipeline or concurrent testers feel memory-constrained:

- `medium_3_0`

### Inspect outputs

```bash
aws cloudformation describe-stacks \
  --region us-east-1 \
  --stack-name psich-ai-dev \
  --query "Stacks[0].Outputs"
```

### Re-deploy code after pushing changes

SSH to the instance and run:

```bash
sudo /usr/local/bin/deploy-psich-ai
```

### Stop billing

Lightsail instances still bill while stopped. To stop compute billing, delete the stack:

```bash
aws cloudformation delete-stack \
  --region us-east-1 \
  --stack-name psich-ai-dev
```

If you need to preserve data before deleting, create a manual snapshot first in Lightsail.
