# Docker Lab 6: Environment Variables and Resource Management

## Overview

This lab demonstrates how to configure Docker environment variables using three methods:

- Passing environment variables directly using `-e`.
- Loading environment variables from a file using `--env-file`.
- Defining environment variables in a Dockerfile using `ENV`.

It also covers container resource limits and resource monitoring.

## Project Structure

```text
Docker/Lab6/
├── PythonApp/
│   ├── Dockerfile
│   ├── Dockerfile.hardcoded
│   ├── app.py
│   ├── env.txt
│   └── requirements.txt
├── screenshots/
│   ├── 01-image-build-and-size.png
│   ├── 02-container1-running-and-env.png
│   ├── 03-create-env-file.png
│   ├── 04-container2-env-file.png
│   ├── 05-hardcoded-env-dockerfile.png
│   ├── 06-build-hardcoded-image.png
│   └── 07-run-container-and-curl.png
└── README.md
```

## Prerequisites

- Docker installed and running.
- Basic knowledge of Docker images and containers.

## Step 1: Build the Docker Image

Navigate to the application directory:

```bash
cd ~/ivolve-labs/Docker/Lab6/PythonApp
```

Build the Docker image:

```bash
docker build -t ivolve1 .
```

Verify the image:

```bash
docker images ivolve1
```

![Docker image build and size](./screenshots/01-image-build-and-size.png)

## Step 2: Run a Container with Environment Variables and Resource Limits

Run the container with environment variables passed directly using `-e`, while limiting CPU and memory resources:

```bash
docker run -d \
  --name container1 \
  -p 5000:5000 \
  -e APP_NAME=iVolveApp1 \
  -e APP_ENV=stg \
  --cpus=1 \
  --memory=256m \
  ivolve1
```

Check the container status:

```bash
docker ps
```

Verify the application:

```bash
curl http://localhost:5000
```

Verify the environment variables inside the container:

```bash
docker exec container1 printenv | grep '^APP_'
```

Expected environment variables:

```text
APP_NAME=iVolveApp1
APP_ENV=stg
```

![Container 1 running with environment variables](./screenshots/02-container1-running-and-env.png)

## Step 3: Monitor Container Resources

Monitor CPU and memory usage while `container1` is running:

```bash
docker stats container1 --no-stream
```

Inspect the container configuration:

```bash
docker inspect container1
```

The container is configured with a CPU limit of 1 CPU and a memory limit of 256 MB.

After completing the first experiment, remove the container and its image:

```bash
docker rm -f container1
docker rmi ivolve1
```

## Step 4: Configure Environment Variables Using an Environment File

The `env.txt` file contains:

![Creating the environment variable file](./screenshots/03-create-env-file.png)

```text
APP_NAME=iVolveApp2
APP_ENV=prod
```

Build the image again if it was removed in the previous step:

```bash
docker build -t ivolve1 .
```

Run a new container using `--env-file`:

```bash
docker run -d \
  --name container2 \
  -p 5000:5000 \
  --env-file env.txt \
  ivolve1
```

Verify the application response:

```bash
curl http://localhost:5000
```

Verify the environment variables:

```bash
docker exec container2 printenv | grep '^APP_'
```

Expected environment variables:

```text
APP_NAME=iVolveApp2
APP_ENV=prod
```

After completing the second experiment, remove the container and image:

```bash
docker rm -f container2
docker rmi ivolve1
```

![Container 2 running with the environment file](./screenshots/04-container2-env-file.png)

## Step 5: Define Environment Variables in the Dockerfile

The `Dockerfile.hardcoded` file defines the following environment variables:

```dockerfile
ENV APP_NAME=iVolveApp3
ENV APP_ENV=dev
```

Build a new image using the alternate Dockerfile:

```bash
docker build -t ivolve3 -f Dockerfile.hardcoded .
```

Verify the image:

```bash
docker images ivolve3
```

![Environment variables defined in the Dockerfile](./screenshots/05-hardcoded-env-dockerfile.png)

![Building the image from the alternate Dockerfile](./screenshots/06-build-hardcoded-image.png)

## Step 6: Run a Container Using Dockerfile Environment Variables

Run the container:

```bash
docker run -d \
  --name container3 \
  -p 5000:5000 \
  ivolve3
```

Verify the application response:

```bash
curl http://localhost:5000
```

Verify the environment variables:

```bash
docker exec container3 printenv | grep '^APP_'
```

Expected environment variables:

```text
APP_NAME=iVolveApp3
APP_ENV=dev
```

![Running the container and testing the application](./screenshots/07-run-container-and-curl.png)

## Step 7: Cleanup

After completing the final experiment, remove the container and images:

```bash
docker rm -f container3
docker rmi ivolve3
```

Confirm that the test containers have been removed:

```bash
docker ps -a
```

## Important Notes

- Environment variables passed using `-e` or `--env-file` configure the container at runtime.
- Environment variables defined with `ENV` provide default values in the image.
- Runtime environment variables can override values defined in the Dockerfile.
- CPU and memory limits apply only to the container on which they are configured.
- Resource monitoring must be performed before removing the relevant container.

## Key Takeaways

- The `-e` option passes environment variables at runtime.
- The `--env-file` option loads multiple environment variables from a file.
- Dockerfile `ENV` instructions define default environment variables in an image.
- Runtime environment variables can override image defaults.
- CPU and memory limits control container resource consumption.
- `docker exec`, `docker inspect`, `docker stats`, and `curl` help verify container configuration and application behavior.

## Author

**Ahmed Ibrahim Adawy**

- GitHub: [AdawyDevOps](https://github.com/AdawyDevOps)
- LinkedIn: [ahmed-3dawy](https://www.linkedin.com/in/ahmed-3dawy/)
