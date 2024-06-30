# GitHub Runner Docker Image [GRDI]

This is a Docker image for the GitHub Actions Runner.

This image can run multiple runners without needing to have a separate runner installation for each

## Usage

Just create following `docker-compose.yml` file:

```yaml
services:
  runner:
    image: "ghcr.io/deadlinecode/grdi:release"
    environment:
      - RUNNER_TOKEN=XXX
      - RUNNER_REPO=https://github.com/owner/repo
    volumes:
      - ./data:/data
```

You can find the `RUNNER_TOKEN` by creating a new self-hosted runner on any repo and copy the token from the config command.
You should also set the `RUNNER_REPO` to the same repo you got the token from.

By default the runner uses "GRDI Runner" as the name.
If you want to change this or any other setting you can use following environment variables:
- `RUNNER_NAME` - runner name
- `RUNNER_WORKDIR` - runner working directory
- `RUNNER_LABELS` - runner labels
- `RUNNER_GROUP` - runner group

As soon as you are done configuring just run `docker-compose up -d` and the runner will start.

## Examples

### Run a single runner

```yaml
services:
  runner:
    image: "ghcr.io/deadlinecode/grdi:release"
    environment:
      - RUNNER_TOKEN=XXX
      - RUNNER_REPO=https://github.com/owner/repo
    volumes:
      - ./data:/data
```

### Run multiple runners
> Note the two different directories for the runners (data1 and data2)<br/>
> Also note the different runner names (required if both runners are running on the same repo)
```yaml
services:
  runner1:
    image: "ghcr.io/deadlinecode/grdi:release"
    environment:
      - RUNNER_TOKEN=XXX
      - RUNNER_REPO=https://github.com/owner/repo
      - RUNNER_NAME=My Runner 1
    volumes:
      - ./data1:/data
  runner2:
    image: "ghcr.io/deadlinecode/grdi:release"
    environment:
      - RUNNER_TOKEN=XXX
      - RUNNER_REPO=https://github.com/owner/repo
      - RUNNER_NAME=MyRunner2
    volumes:
      - ./data2:/data
```

### Run a single runner with getting access to its working directory
> This will link the working directory the runner uses to ./work so you can access the build files of a job
```yaml
services:
  runner:
    image: "ghcr.io/deadlinecode/grdi:release"
    environment:
      - RUNNER_TOKEN=XXX
      - RUNNER_REPO=https://github.com/owner/repo
      - RUNNER_WORKDIR=/work
    volumes:
      - ./data:/data
      - ./work:/work
```
