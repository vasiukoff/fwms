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

SELECT format('CREATE DATABASE %I', 'fwms')
WHERE NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'fwms')
\gexec
