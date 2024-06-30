#!/bin/bash
if [[ -z "${RUNNER_TOKEN}" || -z "${RUNNER_REPO}" ]]; then
  echo 'RUNNER_TOKEN and RUNNER_REPO must be set'
  exit 1
fi

runnerParams=("--unattended" "--url" "$RUNNER_REPO" "--token" "$RUNNER_TOKEN")
if [[ -z "${RUNNER_NAME}" ]]; then
  RUNNER_NAME="GRDI Runner"
fi
runnerParams+=("--name" "$RUNNER_NAME")

if [[ ! -z "${RUNNER_GROUP}" ]]; then
  runnerParams+=("--runnergroup" "$RUNNER_GROUP")
fi
if [[ ! -z "${RUNNER_LABELS}" ]]; then
  runnerParams+=("--labels" "$RUNNER_LABELS")
fi
if [[ ! -z "${RUNNER_WORKDIR}" ]]; then
  runnerParams+=("--work" "$RUNNER_WORKDIR")
fi

runnerFiles=(".credentials" ".credentials_rsaparams" ".runner")

if [ -z "$(ls -A /data)" ]; then
  echo "No data found, creating new runner..."
  echo "$ ./config.sh ${runnerParams[@]}"
  RUNNER_ALLOW_RUNASROOT="1" ./config.sh "${runnerParams[@]}"

  echo "Copying runner files to /data..."
  for file in ${runnerFiles[@]}; do
    [[ -e $file ]] && cp $file /data
  done
else
  echo "Loading existing runner..."
  for file in ${runnerFiles[@]}; do
    [[ -e /data/$file ]] && cp /data/$file $file
  done
fi

echo "Starting runner..."
RUNNER_ALLOW_RUNASROOT="1" ./run.sh