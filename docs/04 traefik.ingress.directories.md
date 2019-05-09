# Traefik | <small>reverse proxy with directories</small>
As opposed to requiring a dedicated domain we're using a free anonymous dynamic ip service from [AnonDNS](http://anondns.net). As a result, in order to access internal services on the docker network, we will need to address them via `directories` as opposed to `subdomains`.

e.g. `Keycloak` will become `xmansion.anondns.net/keycloak` as opposed to `keycloak.xmansion.anondns.net`.

We'll use [Traefik](https://traefik.io) as a `reverse proxy` to front up a single interface to the outside world and translate incoming external requests to our internal services. Because it'll be visible from the interwebz we can use [LetsEncrypt](https://letsencrypt.org) to provide us with a valid SSL certificate.