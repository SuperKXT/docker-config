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
docker run \
	-p 8080:8080 \
	-e KEYCLOAK_ADMIN=admin \
	-e KEYCLOAK_ADMIN_PASSWORD=admin \
	-e KC_DB=mssql \
	-e KC_DB_URL_HOST=10.0.0.9 \
	-e KC_DB_URL_PORT=1435 \
	-e KC_DB_URL_DATABASE=ActiveSooperWizerNCL \
	-e KC_DB_USERNAME=keycloak \
	-e KC_DB_PASSWORD=spts@3311 \
	-e KC_DB_URL_PROPERTIES=";trustServerCertificate=true;encrypted=false" \
	-e KC_DB_SCHEMA=auth \
	-e KC_TRANSACTION_XA_ENABLED=false \
	quay.io/keycloak/keycloak:latest start-dev
```
