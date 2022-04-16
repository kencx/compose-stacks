.PHONY: plan up recreate logs $(cmd)

plan: .env
	@cd "$(c)" && docker-compose --env-file=../.env config > ../stack && \
		echo "Config for $(c) written to file stack"

logs:
	docker logs -f "$(c)"

up: .env
	cd "$(c)" && docker-compose --env-file=../.env up -d

recreate: .env
	cd "$(c)" && docker-compose --env-file=../.env up -d --force-recreate

cmd = down pull
$(cmd): .env
	cd "$(c)" && docker-compose --env-file=../.env $@

