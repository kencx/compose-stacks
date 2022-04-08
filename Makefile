.PHONY: plan start stop

plan: .env
	@cd "$(c)" && docker-compose --env-file=../.env config > ../stack && \
		echo "Config for $(c) written to file stack"

start: .env
	cd "$(c)" && docker-compose --env-file=../.env up -d

stop: .env
	cd "$(c)" && docker-compose --env-file=../.env down
