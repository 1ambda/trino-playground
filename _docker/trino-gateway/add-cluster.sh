#!/bin/bash

# adding trino cluster to gateway
curl \
  -H "Content-Type: application/json" \
  -X POST localhost:9080/gateway/backend/modify/add \
  -d '{ "name": "trino",
        "proxyTo": "http://trino:8080",
        "active": true,
        "routingGroup": "adhoc"
      }';
