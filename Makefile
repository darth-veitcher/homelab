up-dev:
	docker-compose stop && docker-compose rm -f
	docker-compose up --build

stop-dev:
	docker-compose stop && docker-compose rm -f

up-prod:
	# specify base and pass in additional config
	docker-compose -f docker-compose.yml -f docker-compose-prod.yml stop && \
		docker-compose -f docker-compose.yml -f docker-compose-prod.yml rm -f
	docker-compose -f docker-compose.yml -f docker-compose-prod.yml up

stop-prod:
	# specify base and pass in additional config
	docker-compose -f docker-compose.yml -f docker-compose-prod.yml stop && \
		docker-compose -f docker-compose.yml -f docker-compose-prod.yml rm -f