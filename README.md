# Open Accelerator Infrastructure

The Open Accelerator (OA) environment will be used to host projects that do not require specific compliance certification.

## IDP

The identity provider (IDP) for this environment will be a Keycloak instance hosted in AWS or [GovCloud].

[govcloud]: https://aws.amazon.com/govcloud-us/

## DNS

We will use Amazon Route53 as our DNS service for registering new domain records and for responding to ACME DNS-01 challenges. We will rely on the MOC firewall for outbound DNS service.

## Storage

Primary storage will come from the MOC (Ever)Pure storage appliance.

## Clusters

We will deploy each cluster on a separate VLAN. We will implement appropriate firewall configuration such that managed clusters are able to reach the management cluster, and to expose the console interface for the production cluster on a public endpoint.

### RHOSO Cluster

| Description             | Machine type | Count |
| ----------------------- | ------------ | ----- |
| OpenShift control plane | fc430        | 3     |

The RHOSO cluster will provide the underlying hardware API through which we
manage bare metal nodes and networking in the MOC 2.0 environment.

### Open Accelerator Infra Cluster

| Description             | Machine type | Count |
| ----------------------- | ------------ | ----- |
| OpenShift compute       | r440         | 3     |

The OA infra cluster will run tooling (ACM, ArgoCD) for installing and managing
other clusters. It will host the control planes for clusters deployed using
Hosted Control Planes. We're using the R440s for the infra nodes in order to
provide NVME storage for the hosted `etcd` instances.

#### Special hardware requirements

The compute nodes should have NVME drives for supporting `etcd` for hosted clusters.

### Open Accelerator Production Cluster

| Description             | Machine type | Count |
| ----------------------- | ------------ | ----- |
| OpenShift compute       | fc830        | 3     |
| OpenShift GPU           | h100         | 3     |

The OA production cluster will host Open Accelerator residents.

## Infra notes

We're using the `open-accelerator` project in ESI to acquire hardware for the preliminary cluster installs.
