# Playground for Trino

- LDAP Authentication / Authorization (lldap)
- OAuth2 Authentication (keycloak)
- Ranger Integration
- Gateway Integration
- Metastore Integration (Hive Metastore)
- Storage Integration (S3-compatible Minio)


## Setup

(1) Run containers

```
make compose
```


(2) Prepare SSL Proxy for Authentication

```
make proxy
```

(3) Add Keycloak configuration

```
# Add the following to your /etc/hosts file
127.0.0.1   keycloak
```