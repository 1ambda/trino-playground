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


Execute the following command for local development
- https://github.com/1ambda/trino/pull/2

```
make compose.base
```



(2) Prepare SSL Proxy for Authentication

```
# make proxy.init for generating certs
make proxy
```

(3) Add Keycloak configuration

```
# Add the following to your /etc/hosts file
127.0.0.1   keycloak
127.0.0.1   lldap
127.0.0.1   ranger
```