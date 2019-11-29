# Darth-Veitcher's Homelab 
This repository contains docker details, notes and general setup musings around configuring my (overkill) homelab end-to-end. This has been deliberately done **the hard way** (i.e. handcrafted from scratch) wherever possible so that I understand what's going on under the hood. I'm not a big fan of black boxes.

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
    * [ ] TLS certificates with Cert-Manager
        * [ ] Self-signed Root CA for internal services
        * [ ] Let's Encrypt for external services
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