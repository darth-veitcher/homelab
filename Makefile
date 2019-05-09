up-dev:
	docker-compose stop && docker-compose rm -f
	docker-compose up --build

stop-dev:
	docker-compose stop && docker-compose rm -f

# Homelab
up-lab:
	# scp across the configs
	rsync -rLvP . /tmp/homelab
	rsync -rLvP . rancher@192.168.0.61:/tmp/homelab
	# fix permissions for traefik
	# 	* level=error msg="Failed to read new account, ACME data conversion is not available : permissions 644 for /etc/traefik/acme.json are too open, please use 600"
	# 	* level=error msg="Unable to add ACME provider to the providers list: unable to get ACME account : permissions 644 for /etc/traefik/acme.json are too open, please use 600"
	ssh rancher@192.168.0.61 chmod 600 /tmp/homelab/services/traefik/*
	# Run docker-compose remotely
	docker-compose stop && docker-compose rm -f
	docker-compose up --build

stop-lab:
	docker-compose stop && docker-compose rm -f
	rm -rf /tmp/homelab
	ssh rancher@192.168.0.61 rm -rf /tmp/homelab

up-prod:
	# specify base and pass in additional config
	docker-compose -f docker-compose.yml -f docker-compose-prod.yml stop && \
		docker-compose -f docker-compose.yml -f docker-compose-prod.yml rm -f
	docker-compose -f docker-compose.yml -f docker-compose-prod.yml up

stop-prod:
	# specify base and pass in additional config
	docker-compose -f docker-compose.yml -f docker-compose-prod.yml stop && \
		docker-compose -f docker-compose.yml -f docker-compose-prod.yml rm -f