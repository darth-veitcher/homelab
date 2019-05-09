# Traefik | <small>reverse proxy with directories</small>
As opposed to requiring a dedicated domain we're using a free anonymous dynamic ip service from [AnonDNS](http://anondns.net). As a result, in order to access internal services on the docker network, we will need to address them via `directories` as opposed to `subdomains`.

e.g. `Keycloak` will become `xmansion.anondns.net/auth` as opposed to `keycloak.xmansion.anondns.net`.

We'll use [Traefik](https://traefik.io) as a `reverse proxy` to front up a single interface to the outside world and translate incoming external requests to our internal services. Because it'll be visible from the interwebz we can use [LetsEncrypt](https://letsencrypt.org) to provide us with a valid SSL certificate.

Here's an example set of `labels` that need to be applied to a container in the `docker-compose.yml` file.

```
labels:
      - "trafeik.enable=true"
      - "traefik.backend=keycloak"
      # Auth
      - "traefik.frontend.rule=Host:${ANONDNS}; PathPrefix: /auth"
      - "traefik.port=8080"
      - "trafeik.docker.network=traefik_public"
```

Unpacking the above:

* `trafeik.enable=true`: We have traefik set to only expose externally containers which we have specifically marked as `enabled`. This prevents any private internal services from unwittingly being exposed without us knowing.
* `traefik.frontend.rule=Host:${ANONDNS}; PathPrefix: /auth`: Route traffic to this container based on a match to our environment variable (which represents the dynamicdns domain) as well as having a trailing `/auth` in the address. This will match `xmansion.anondns.net/auth/*` addresses.
* `traefik.port=8080`: Once a request has matched the rule above, route the traffic to port `8080` on the container.