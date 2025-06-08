# GitHub Runner Helm Chart - CRD Installation

This chart requires CustomResourceDefinitions (CRDs) for the `actions-runner-controller` to be installed in your cluster. Due to potential issues with CRD size and Helm, these are managed by the `CRD.sh` script.

The script targets `actions-runner-controller` CRD version `v0.27.1`.

## Instructions

1.  **Ensure Prerequisites**:
    *   `kubectl` installed and configured.
    *   `curl` installed.
    *   `zsh` shell.

2.  **Run the CRD Installation Script**:
    Navigate to this directory (`/home/kumori/code/home/argocd/system/github-runner/`) and execute:
    ```sh
    chmod +x CRD.sh
    ./CRD.sh
    ```
    The script will download the official CRDs, then use `kubectl replace --force` to install/update them in your cluster, and finally clean up the downloaded files.

After the script completes successfully, you can proceed with deploying the Helm chart.
