---
abstract: >-
    A Helm chart to install PostgreSQL in single or clustered configuration.
authors:
    - name: Xander Harris
      email: xandertheharris@gmail.com
date: 2024-07-31
title: Readme
---

[![wakatime](https://wakatime.com/badge/github/edwardtheharris/helm-postgresql.svg)](https://wakatime.com/badge/github/edwardtheharris/helm-postgresql)

This chart deploys PostgreSQL in either a single-node or cluster configuration.

## Usage

### Install

To install this chart follow these steps.

1. Create a namespace.

   ```shell
   kubectl create ns postgresql
   ```

2. Install the unittest Helm plugin.

   ```shell
   helm plugin install https://github.com/helm-unittest/helm-unittest
   ```

3. Run the unit tests.

   ```shell
   helm unittest -f 'tests/*.yaml' .
   ```

   You should see output similar to this.

   ```shell
   ### Chart [ postgresql ] .

   PASS  PostgreSQL Service Test Suite    tests/service_test.yaml
   PASS  PostgreSQL ServiceAccount Test Suite     tests/serviceaccount_test.yaml
   PASS  PostgreSQL StatefulSet Test Suite        tests/statefulset_test.yaml

   Charts:      1 passed, 1 total
   Test Suites: 3 passed, 3 total
   Tests:       9 passed, 9 total
   Snapshot:    0 passed, 0 total
   Time:        92.722398ms
   ```

4. Install the chart with Helm.

   ```shell
   helm -n postgresql install postgresql .
   ```

5. Run the tests included with Helm.

   ```shell
   helm -n postgresql test postgresql
   ```

### Uninstall

This can be done in the usual way.

```shell
helm -n postgresql uninstall postgresql
```
