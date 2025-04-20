TAG = "MAKE"

.PHONY: open
open:
	@ echo ""
	@ echo ""
	@ echo "[$(TAG)] ($(shell date '+%H:%M:%S')) - Open service UI"
	@ open http://localhost:9001;  # Minio UI
	@ open http://localhost:8443;  # Trino UI
	@ open http://localhost:9443;  # Trino Gateway UI
	@ open http://localhost:6080;  # Ranger UI
	@ open http://localhost:17170; # LDAP UI
	@ open http://localhost:8080;  # Keycloak UI
	@ echo ""

.PHONY: compose
compose:
	docker compose \
		-f docker-compose.yaml \
		-f docker-compose.trino.yaml \
		up

.PHONY: compose.base
compose.base:
	docker compose \
		-f docker-compose.yaml \
		up

.PHONY: compose.clean
compose.clean:
	@ echo ""
	@ echo ""
	@ echo "[$(TAG)] ($(shell date '+%H:%M:%S')) - Cleaning container volumes ('docker/volume')"
	@ docker container prune -f
	@ docker volume prune -f
	@ echo ""
	@ echo ""

.PHONY: trino.shell
trino.shell:
	docker exec -w /etc/trino -it trino /bin/bash

.PHONY: trino.init
trino.init:
	@ echo ""
	@ echo "[$(TAG)] ($(shell date '+%H:%M:%S')) - Creating Trino schemas"
	@ echo ""
	@ trino --server http://localhost:8080 --file _script/trino.init-schema.sql;
	@ echo ""


.PHONY: proxy.init
proxy.init:
	@ echo ""
	@ echo "[$(TAG)] ($(shell date '+%H:%M:%S')) - Preparing Proxy"
	@ echo ""
	@ brew install mkcerts || true;
	@ mkcert -install || true;
	@ mkcert localhost || true;
	@ npm install -g local-ssl-proxy || true;
	@ local-ssl-proxy --config ./localhost-proxy.json


.PHONY: proxy
proxy:
	@ echo ""
	@ echo "[$(TAG)] ($(shell date '+%H:%M:%S')) - Starting Proxy"
	@ echo ""
	@ local-ssl-proxy --config ./localhost-proxy.json

.PHONY: ldap.init
ldap.init:
	@ echo ""
	@ echo "[$(TAG)] ($(shell date '+%H:%M:%S')) - Populate LDAP server"
	@ echo ""
	@ docker compose exec lldap /bootstrap/bootstrap.sh


.PHONY: gateway.init
gateway.init:
	@ echo ""
	@ echo "[$(TAG)] ($(shell date '+%H:%M:%S')) - Gateway server"
	@ echo ""
	@ ./_docker/trino-gateway/add-cluster.sh
