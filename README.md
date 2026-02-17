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

Now everything should be up and running locally

## Usage

Refer to usage of each service in their invidual repo readme.md.

- BE - https://github.com/JuozasPetryla/eeg-be
- FE - https://github.com/JuozasPetryla/eeg-fe
- ML-pipeline - https://github.com/JuozasPetryla/eeg-ml-pipeline