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

# Why? What problems am I solving?
Probably the most important question before disappearing down the rabbit hole is `Why?`. From my perspective I'm looking to address a couple of specific use cases, which then drive the requirements.

* **Data (Work)**: The ability to capture, store, process and analyse large volumes of data in a cost effective fashion.
* **Home (Production)**: I want to run some services at home (e.g. Plex, DNS, Git).
* **Study (Play)**: With a habit for tinkering I'd like to be able to write code and then seamlessly deploy in a secure fashion without needing to worry about the infrastructure underneath. I don't like being hit for a steady drip feed of pay-as-you go type cost for what's essentially a hobby though so would prefer to run on some old hardware I can just sweat.

Ideally I'd also like to be able to access this external from the house wherever I am. In addition, with multiple bits of hardware available to me (hangover from tinkering for years) it would be good to be able to spin up/down capacity whenever needed without having to worry about the impact on services.

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
    * [x] Identity and Access Management with OIDC
        * [x] OpenLDAP as directory service
        * [x] KeyCloak/Dex as identity provider
            * [x] Multi-factor auth for key admin users
        * [ ] OIDC Forward Auth for additional fine grained RBAC
* [ ] Secure VPN access for users
    * [ ] Integrated with PKI
    * [ ] Integrated with IDAM, Keycloak+OpenLDAP

* [ ] Services Stack: Developer
    * [ ] Docker registry
    * [ ] Gitea
    * [ ] TimeMachine backup for Apple devices