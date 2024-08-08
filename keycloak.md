## If the database already has an existing auth schema

```sql
USE [ActiveSooperWizerNCL];
GO

ALTER AUTHORIZATION ON SCHEMA::auth TO dbo;
GO

DROP USER keycloak;
GO

CREATE USER keycloak FOR LOGIN keycloak;
GO

ALTER ROLE db_owner ADD MEMBER keycloak;
GO

ALTER USER keycloak WITH DEFAULT_SCHEMA = auth;
GO

SELECT SCHEMA_NAME() EXECUTE AS USER='keycloak';
GO
```

## If the database does not have an existing auth schema

```sql
USE master;
GO

CREATE LOGIN keycloak WITH PASSWORD = 'spts@3311';
GO

CREATE USER keycloak FOR LOGIN keycloak;
GO

USE [ActiveSooperWizerNCL];
GO

ALTER ROLE db_owner ADD MEMBER keycloak;
GO

DROP SCHEMA auth;
GO

CREATE SCHEMA auth AUTHORIZATION keycloak;
GO

ALTER USER keycloak WITH DEFAULT_SCHEMA = auth;
GO

SELECT SCHEMA_NAME() EXECUTE AS USER='keycloak';
GO
```

```bash
docker compose -f keycloak.yaml up -d
```
