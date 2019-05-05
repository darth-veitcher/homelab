# Darth-Veitcher's Homelab | <small>An overkill setup.</small>
This repository contains docker details, notes and general setup musings around configuring a homelab end-to-end. This has been deliberately done **the hard way** (i.e. handcrafted from scratch) wherever possible so that I understand what's going on under the hood. I'm not a big fan of black boxes.

## High level requirements and roadmap
* [ ] Identity and Access Management
    * [ ] OpenLDAP via [osixia/openldap](https://github.com/osixia/docker-openldap)
    * [ ] Kerberos
    * [ ] Multi-Factor Auth via [Authelia](https://github.com/clems4ever/authelia)
* [ ] Network
    * [ ] DNS
    * [ ] DHCP
    * [ ] Trusted internal SSL Root CA via [cfssl](https://github.com/cloudflare/cfssl)

