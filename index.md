---
abstract: >-
   Helm PostgreSQL documentation master file, created by
   sphinx-quickstart on Sun Apr 28 15:35:08 2024.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
authors:
  - name: Xander Harris
    email: xandertheharris@gmail.com
date: 2024-04-28
title: Postgres Helm Chart
---

## Repository Contents

```{contents}
```

```{toctree}
:caption: general

tests/index
```

```{toctree}
:caption: meta

.github/index
changelog
license
readme
security
```

## Indices and tables

* {ref}`genindex`
* {ref}`modindex`
* {ref}`search`

```{include} readme.md
```

### Chart

```{autoyaml} Chart.yaml
```

#### Values

```{autoyaml} values.yaml
```

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>
```
