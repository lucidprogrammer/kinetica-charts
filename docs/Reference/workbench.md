---
hide:
  - navigation
tags:
  - Reference
---
# Kinetica Workbench Configuration

* kubectl (yaml)
* Helm Chart

## Workbench

=== "kubectl"

Using kubetctl a CustomResource of type `KineticaCluster` is used to define a new Kinetica DB Cluster in a yaml file.

The basic Group, Version, Kind or GVK to instantiate a Kinetica Workbench is as follows: -

```yaml title="Workbench GVK" linenums="1"
apiVersion: workbench.com.kinetica/v1
kind: Workbench

```

### Metadata

to which we add a `metadata:` block for the name of the DB CR along with the `namespace` into which we are
targetting the installation of the DB cluster.

```yaml title="Workbench metadata" linenums="1"
apiVersion: workbench.com.kinetica/v1
kind: Workbench
metadata:
  name: workbench-kinetica-cluster
  namespace: gpudb
```

The simplest valid Workbench CR looks as follows: -

```yaml title="workbench.yaml" linenums="1"
apiVersion: workbench.com.kinetica/v1
kind: Workbench
metadata:
  name: workbench-kinetica-cluster
  namespace: gpudb
spec:
  executeSqlLimit: 10000
  fqdn: kinetica-cluster.saas.kinetica.com
  image: kinetica/workbench:v7.1.9-8.rc1
  letsEncrypt:
    enabled: false
  userIdleTimeout: 60
  ingressController: nginx-ingress
```

`1. clusterName` - the user defined name of the Kinetica DB Cluster

`2. clusterSize` - block that defines the number of DB Ranks to run

=== "helm"
