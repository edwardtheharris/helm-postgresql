# syntax=docker/dockerfile:1
FROM postgres:16-alpine
LABEL org.opencontainers.image.source="https://github.com/edwardtheharris/helm-postgresql"
RUN apk add --no-cache bash bash-completion sudo
COPY --chmod=ug+x bin/entrypoint.sh /bin/entrypoint.sh
COPY --chown=postgres:postgres conf/pg_hba.conf /docker-entrypoint-initdb.d/pg_hba.conf
EXPOSE 5432
CMD ["/bin/entrypoint.sh"]

