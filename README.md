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
