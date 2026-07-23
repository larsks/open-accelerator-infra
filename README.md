# Open Accelerator Infrastructure

## Clusters

### RHOSO Cluster

| Description             | Machine type | Count |
| ----------------------- | ------------ | ----- |
| OpenShift control plane | fc430        | 3     |

The RHOSO cluster will provide the underlying hardware API through which we
manage bare metal nodes and networking in the MOC 2.0 environment.

### Open Accelerator Infra Cluster

| Description             | Machine type | Count |
| ----------------------- | ------------ | ----- |
| OpenShift control plane | fc430        | 3     |
| OpenShift compute       | r440         | 3     |

The OA infra cluster will run tooling (ACM, ArgoCD) for installing and managing other clusters. It will host the control planes for clusters deployed using Hosted Control Planes.

#### Special hardware requirements

The compute nodes should have NVME drives for supporting etcd for hosted clusters.

### Open Accelerator Production Cluster

| Description             | Machine type | Count |
| ----------------------- | ------------ | ----- |
| OpenShift compute       | fc830        | 3     |
| OpenShift GPU           | h100         | 3     |

The OA production cluster will host Open Accelerator residents.
