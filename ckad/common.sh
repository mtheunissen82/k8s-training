#!/bin/bash

wait_for_pending_pod() {
  local pod_name=$1
  local phase="Pending"
  local attempt=0
  local max_attempts=10

  while [[ $phase == "Pending" && $attempt -le $max_attempts ]]; do
    ((attempt=attempt+1))

    phase="$(kubectl get pod "$1" --output=jsonpath='{.status.phase}')"
    echo "Pod '$pod_name' phase 'Pending' (attempt #${attempt})"

    sleep 1
  done

  if [[ $attempt -ge $max_attempts ]]; then
    echo "Waiting for pod failed (Max. attempts '$max_attempts' reached)" 1>&2
    return 1
  fi

  echo "Pod '$pod_name' phase '$phase'"
}

get_pod_ip() {
  local pod_name="$1"

  kubectl get pod "$pod_name" -o jsonpath='{.status.podIP}'
}
