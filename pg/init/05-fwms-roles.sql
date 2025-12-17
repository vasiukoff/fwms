-- fWMS roles: admin-fwms, app-admin, app-usr, usr-fwms

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='admin-fwms') THEN
    CREATE ROLE "admin-fwms" LOGIN;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='app-admin') THEN
    CREATE ROLE "app-admin" LOGIN;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='app-usr') THEN
    CREATE ROLE "app-usr" LOGIN;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='usr-fwms') THEN
    CREATE ROLE "usr-fwms" LOGIN;
  END IF;
END$$;

-- Желаемая БД. Можно опираться на POSTGRES_DB, но пусть будет явно.
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'fwms') THEN
    CREATE DATABASE fwms;
  END IF;
END$$;
