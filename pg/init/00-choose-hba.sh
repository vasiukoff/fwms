#!/bin/sh
set -eu

PROFILE="${PG_HBA_PROFILE:-prod}" # prod|test

case "$PROFILE" in
  test) SRC="/opt/fwms/fwms-pg_hba.test.conf" ;;
  prod) SRC="/opt/fwms/fwms-pg_hba.prod.conf" ;;
  *) echo "Unknown PG_HBA_PROFILE=$PROFILE (use prod|test)"; exit 1 ;;
esac

echo "fWMS: applying pg_hba profile: $PROFILE"
cp -f "$SRC" "$PGDATA/pg_hba.conf"
chmod 0600 "$PGDATA/pg_hba.conf"
