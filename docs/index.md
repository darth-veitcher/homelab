# Darth-Veitcher's Homelab | <small>An overkill setup.</small>
This repository contains docker details, notes and general setup musings around configuring a homelab end-to-end. This has been deliberately done **the hard way** (i.e. handcrafted from scratch) wherever possible so that I understand what's going on under the hood. I'm not a big fan of black boxes.

## High level requirements and roadmap
* [ ] Containerised deployment
    * [ ] Single node (docker)
* [ ] Identity and Access Management
    * [x] OpenLDAP via [osixia/openldap](https://github.com/osixia/docker-openldap)
    * [ ] Multi-Factor Auth via [Keycloak](https://github.com/clems4ever/authelia)
        * [ ] Integrated with [Traefik](https://traefik.io) reverse proxy with [ForwardAuth](https://docs.traefik.io/v2.0/middlewares/forwardauth/) settings.
* [ ] Public Key Infrastructure with [cfssl](https://github.com/cloudflare/cfssl) for internal services


