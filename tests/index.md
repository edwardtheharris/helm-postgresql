---
abstract: >-
   Documentation of the unit tests for this repository.
authors:
   - name: Xander Harris
     email: xandertheharris@gmail.com
date: 2024-04-28
title: PostgreSQL Unit Tests
---

```{contents}
```

## Tests Usage

To run these tests you need to install the unittest plugin.

1. Install the plugin.

   ```shell
   helm plugin install https://github.com/helm-unittest/helm-unittest
   ```

2. Run the tests.

   ```{code-block} shell
   helm unittest -f 'tests/*.yaml' .
   ```

### Service Test

```{autoyaml} tests/service_test.yaml
```

### ServiceAccount Test

```{autoyaml} tests/serviceaccount_test.yaml
```

### StatefulSet Test

```{autoyaml} tests/statefulset_test.yaml
```
