# GitHub Actions Self-Hosted Runner on AWS EC2

## Project Overview

This project demonstrates how to configure and run a **GitHub Actions Self-Hosted Runner on an AWS EC2 instance**.

Instead of using GitHub-hosted runners, I configured my own AWS EC2 instance to execute GitHub Actions workflows.

## Architecture

```text
        Developer
            |
            | Git Push
            v
     GitHub Repository
            |
            v
     GitHub Actions
            |
            v
    Self-Hosted Runner
        (AWS EC2)
            |
            v
     Execute Workflow
            |
            v
      Job Results
            |
            v
      GitHub Actions
```

## Technologies Used

- AWS EC2
- Amazon Linux
- GitHub Actions
- Self-Hosted Runner
- Linux Commands
- Git
- YAML

## Implementation Steps

### 1. Create AWS EC2 Instance

- Launched an EC2 instance on AWS.
- Selected Amazon Linux.
- Configured SSH access.
- Connected to EC2 using SSH.

### 2. Install Required Packages

```bash
sudo dnf update -y
sudo dnf install git curl wget tar unzip -y
```

Verify Git:

```bash
git --version
```

### 3. Create Runner Directory

```bash
mkdir actions-runner
cd actions-runner
```

### 4. Configure GitHub Self-Hosted Runner

1. Open the GitHub repository.
2. Navigate to Settings.
3. Select Actions → Runners.
4. Click New self-hosted runner.
5. Select Linux and x64.
6. Follow the download, extraction, and configuration commands displayed by GitHub.

### 5. Start the Runner

```bash
./run.sh
```

Expected output:

```text
Connected to GitHub
Listening for Jobs
```

### 6. Run Runner as a Service

```bash
sudo ./svc.sh install ec2-user
sudo ./svc.sh start
sudo ./svc.sh status
```

### 7. GitHub Actions Workflow

Workflow file:

`.github/workflows/runner-test.yml`

```yaml
name: Self-Hosted Runner Test

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  runner-test:
    name: Test AWS EC2 Runner
    runs-on: self-hosted

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Display Welcome Message
        run: echo "Hello DevOps! My self-hosted runner is working."

      - name: Check Operating System
        run: uname -a

      - name: Check Git Version
        run: git --version

      - name: Display Hostname
        run: hostname

      - name: Display Date
        run: date

      - name: Success Message
        run: echo "Workflow executed successfully on AWS EC2!"
```

## Key Learnings

- Understanding GitHub-hosted vs Self-hosted runners.
- Configuring a self-hosted runner on AWS EC2.
- Connecting GitHub Actions with an EC2 instance.
- Executing CI/CD jobs on custom infrastructure.
- Installing and managing Linux dependencies.
- Managing the runner as a Linux service.
- Troubleshooting workflow execution errors.

## Benefits of Self-Hosted Runners

- Control over the execution environment.
- Custom software and tool installation.
- Access to private infrastructure.
- Reusable compute resources for CI/CD jobs.

## Security Best Practices

- Restrict SSH access to your own IP address.
- Never expose GitHub runner registration tokens.
- Do not store AWS credentials in workflow files.
- Avoid running untrusted pull-request workflows on privileged runners.
- Stop or terminate EC2 resources when not needed.

## Author

**Venkatesh**

Cloud & DevOps Engineer | AWS | Linux | Networking | Terraform | Jenkins | GitHub Actions

GitHub: https://github.com/venkatesh762004/github-self-hosted-runner.git

---

*This project was implemented as part of my hands-on AWS and DevOps learning journey.*
