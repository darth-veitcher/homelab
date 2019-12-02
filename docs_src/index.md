# Darth-Veitcher's Homelab 
This repository contains docker details, notes and general setup musings around configuring my (overkill) homelab end-to-end. This has been deliberately done **the hard way** (i.e. handcrafted from scratch) wherever possible so that I understand what's going on under the hood. I'm not a big fan of black boxes.

You'll undoubtedly find quicker and easier `getting started with Kubernetes` guides elsewhere online (personally I'd recommend looking at some of the excellent posts by [Alex Ellis](https://blog.alexellis.io/raspberry-pi-homelab-with-k3sup/)) but I wanted something fully featured.

This setup is opinionated and features the following:

* Hybrid cloud setup with nodes both on-premise (bare metal) and cloud (dedicated servers)
* VPN links for secure access between nodes
* Redundant Ceph storage
* Monitoring via Prometheus, visualisation with Grafana
* TLS certificates via LetsEncrypt
* Integrated Identity and Access Management (IDAM), supporting multiple protocols (incl. Oauth, OIDC and LDAP) via Keycloak

## High level requirements, roadmap and table of contents
* [ ] Reference Architecture (appendix)
* [x] Configuring physical nodes
    * [x] VPN between nodes
    * [ ] Basic hardening
* [ ] Configuring kubernetes
    * [x] Networking and Network Policy via Canal
    * [x] Service Discovery via CoreDNS
    * [x] Ceph storage via Rook
        * [x] Block storage for pods
        * [x] Shared filesystem
        * [x] Object storage
            * [ ] with [LDAP for authentication](https://docs.ceph.com/docs/master/radosgw/ldap-auth/); and
            * [ ] with [Vault for secure key management](https://docs.ceph.com/docs/master/radosgw/vault/)
        * [x] With dashboard
            * [x] Enabled [object gateway management](https://docs.ceph.com/docs/master/mgr/dashboard/#enabling-the-object-gateway-management-frontend)
            * [ ] via [SSO](https://docs.ceph.com/docs/master/mgr/dashboard/#enabling-single-sign-on-sso)
        * [x] Monitoring with Prometheus and Grafana
    * [ ] Cloudflare integration with `external-dns`
    * [x] TLS certificates with Cert-Manager
        * [ ] Self-signed Root CA for internal services
        * [x] Let's Encrypt for external services
    * [ ] Identity and Access Management with OIDC
        * [ ] OpenLDAP as directory service
        * [ ] KeyCloak/Dex as identity provider
            * [ ] Multi-factor auth for key admin users
        * [ ] OIDC Forward Auth for additional fine grained RBAC
* [ ] Secure VPN access for users
    * [ ] Integrated with PKI
    * [ ] Integrated with IDAM, Keycloak+OpenLDAP

* [ ] Services Stack: Developer
    * [ ] Docker registry
    * [ ] Gitea