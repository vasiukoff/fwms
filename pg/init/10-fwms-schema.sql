\connect fwms

-- 1) Схемы
CREATE SCHEMA IF NOT EXISTS fwms AUTHORIZATION "admin-fwms";
CREATE SCHEMA IF NOT EXISTS fwms_public AUTHORIZATION "admin-fwms";

-- 2) Базовая гигиена: закрываем public
REVOKE ALL ON SCHEMA public FROM PUBLIC;

-- 3) Права на схемы
-- Админы: всё
GRANT USAGE, CREATE ON SCHEMA fwms, fwms_public TO "admin-fwms";
GRANT USAGE, CREATE ON SCHEMA fwms, fwms_public TO "app-admin";

-- Приложение-пользователь: только использование схем (без CREATE)
GRANT USAGE ON SCHEMA fwms, fwms_public TO "app-usr";

-- Обычный пользователь: только публичная схема
GRANT USAGE ON SCHEMA fwms_public TO "usr-fwms";

-- 4) Пример таблиц
CREATE TABLE IF NOT EXISTS fwms.stock_items (
  id bigserial PRIMARY KEY,
  sku text NOT NULL,
  qty bigint NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS fwms_public.user_view (
  sku text PRIMARY KEY,
  qty bigint NOT NULL
);

-- 5) Права на таблицы
-- Полный доступ админам
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA fwms, fwms_public TO "admin-fwms";
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA fwms, fwms_public TO "app-admin";

-- app-usr: типично CRUD на рабочих таблицах
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA fwms, fwms_public TO "app-usr";

-- usr-fwms: только чтение публичных представлений/таблиц
GRANT SELECT ON ALL TABLES IN SCHEMA fwms_public TO "usr-fwms";

-- 6) Default privileges (чтобы новые таблицы наследовали политику)
ALTER DEFAULT PRIVILEGES IN SCHEMA fwms
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO "app-usr";
ALTER DEFAULT PRIVILEGES IN SCHEMA fwms
  GRANT ALL PRIVILEGES ON TABLES TO "admin-fwms";
ALTER DEFAULT PRIVILEGES IN SCHEMA fwms
  GRANT ALL PRIVILEGES ON TABLES TO "app-admin";

ALTER DEFAULT PRIVILEGES IN SCHEMA fwms_public
  GRANT SELECT ON TABLES TO "usr-fwms";
ALTER DEFAULT PRIVILEGES IN SCHEMA fwms_public
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO "app-usr";
ALTER DEFAULT PRIVILEGES IN SCHEMA fwms_public
  GRANT ALL PRIVILEGES ON TABLES TO "admin-fwms";
ALTER DEFAULT PRIVILEGES IN SCHEMA fwms_public
  GRANT ALL PRIVILEGES ON TABLES TO "app-admin";
