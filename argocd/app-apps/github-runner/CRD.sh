#!/bin/zsh

# Script to download and apply actions-runner-controller CRDs
# Run this script from the directory where you want the CRD YAML files to be downloaded.

CRD_VERSION="v0.27.1"
CRD_BASE_URL="https://raw.githubusercontent.com/actions-runner-controller/actions-runner-controller/${CRD_VERSION}/config/crd/bases"
CRDS=(
  "actions.summerwind.dev_horizontalrunnerautoscalers.yaml"
  "actions.summerwind.dev_runnerdeployments.yaml"
  "actions.summerwind.dev_runnerreplicasets.yaml"
  "actions.summerwind.dev_runners.yaml"
  "actions.summerwind.dev_runnersets.yaml"
)

echo "Starting CRD installation/update..."

for crd_file in "${CRDS[@]}"; do
  echo "Processing ${crd_file}..."

  # Download the CRD file
  echo "  Downloading ${crd_file}..."
  curl -sLO "${CRD_BASE_URL}/${crd_file}"
  if [ $? -ne 0 ]; then
    echo "  ERROR: Failed to download ${crd_file}. Skipping."
    continue
  fi

  # Replace the CRD in the cluster
  # The --force flag will delete and re-create if necessary.
  echo "  Replacing CRD using ${crd_file}..."
  kubectl replace --force -f "${crd_file}"
  if [ $? -ne 0 ]; then
    echo "  ERROR: Failed to replace CRD using ${crd_file}. The file ${crd_file} will be kept for inspection."
    continue # Skip deleting the file if replace failed
  fi

  # Delete the local CRD file
  echo "  Deleting local file ${crd_file}..."
  rm "${crd_file}"

  echo "  Successfully processed ${crd_file}."
done

echo "CRD installation/update script finished."
