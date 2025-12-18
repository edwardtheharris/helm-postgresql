#!/bin/bash

datadir="$(ls /var/lib/postgresql/data)"

if [[ "$datadir" == "" ]]; then
  sudo -u postgres initdb -A trust -D /var/lib/postgresql/data
  cp /docker-entrypoint-initdb.d/pg_hba.conf /var/lib/postgresql/data/
fi

exec sudo -u postgres postgres -D /var/lib/postgresql/data
