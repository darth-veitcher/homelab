# Darth-Veitcher's Homelab 
This repository contains docker details, notes and general setup musings around configuring my (overkill) homelab end-to-end. This has been deliberately done **the hard way** (i.e. handcrafted from scratch) wherever possible so that I understand what's going on under the hood. I'm not a big fan of black boxes.

## High level requirements and roadmap
* [ ] Containerised deployment
    * [ ] Single node (docker)
    * [ ] Services can be executed 
        * [ ] individually
        * [ ] single monolithoic command
* [ ] Identity and Access Management (IDAM)
    * [x] OpenLDAP via [osixia/openldap](https://github.com/osixia/docker-openldap)
        * [x] Initial seeding of groups and users
    * [x] Multi-Factor Auth via [Keycloak](https://github.com/clems4ever/authelia)
        * [x] Integrated with LDAP for users and groups
        * [x] Integrated with [Traefik](https://traefik.io) reverse proxy 
            * [ ] with [ForwardAuth](https://docs.traefik.io/v2.0/middlewares/forwardauth/) settings; or
            * [ ] with [Gatekeeper]()
* [x] Free, anonymous Dynamic DNS
* [ ] Local DNS with dnsmasq
* [x] [LetsEncrypt](https://letsencrypt.org) trusted SSL for external services
* [ ] Public Key Infrastructure (PKI) with [cfssl](https://github.com/cloudflare/cfssl) for internal services
* [ ] Secure VPN access for users
    * [ ] Integrated with PKI
    * [ ] Integrated with IDAM, Keycloak+OpenLDAP


