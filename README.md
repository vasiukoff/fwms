## fWMS PostgreSQL

```bash
podman run -d \
  -e POSTGRES_PASSWORD=secret \
  -e PG_HBA_PROFILE=prod \
  -p 5432:5432 \
  ghcr.io/vasiukoff/fwms/pg:17
