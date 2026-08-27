	-- Fermeture du schéma public par défaut, en premier
REVOKE ALL PRIVILEGES ON SCHEMA public FROM public;

-- Rôle lecture seule
CREATE ROLE dwh_northwind_readonly;
GRANT CONNECT ON DATABASE dwh_northwind TO dwh_northwind_readonly;
GRANT USAGE ON SCHEMA public TO dwh_northwind_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO dwh_northwind_readonly;

-- Rôle dbt
CREATE ROLE dwh_northwind_dbt;
GRANT CONNECT ON DATABASE dwh_northwind TO DWH_dbt_project;
GRANT USAGE ON SCHEMA public TO DWH_dbt_project;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO DWH_dbt_project;
GRANT CREATE ON DATABASE dwh_northwind TO DWH_dbt_project;

-- Utilisateurs
CREATE USER analyste WITH PASSWORD 'analyste123';
GRANT dwh_northwind_readonly TO analyste;

CREATE USER dbt_user WITH PASSWORD 'zawl';
GRANT dwh_northwind TO dbt_user;

-- Droits par défaut sur les futures tables créées par dbt_user
ALTER DEFAULT PRIVILEGES FOR ROLE DWH_dbt_project IN SCHEMA public
GRANT SELECT ON TABLES TO dwh_northwind;

ALTER DEFAULT PRIVILEGES FOR ROLE northwind_readonly IN SCHEMA public
GRANT SELECT ON TABLES TO dwh_northwind_readonly;