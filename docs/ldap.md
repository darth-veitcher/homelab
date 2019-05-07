# OpenLDAP | <small>Directory Information</small>

We're going to follow a previous tutorial I wrote for setting up an initial OpenLDAP installation on a VM and then seed an initial admin user.

Dockerising this is done now with the `osixia/openldap` base image which can be found on [GitHub](https://github.com/osixia/docker-openldap).

We'll follow the [Seed ldap database with ldif](https://github.com/osixia/docker-openldap#seed-ldap-database-with-ldif) method to modify and seed our initial datasets which also supports the following substitutions.

* `{{ LDAP_BASE_DN }}`
* `{{ LDAP_BACKEND }}`
* `{{ LDAP_DOMAIN }}`
* `{{ LDAP_READONLY_USER_USERNAME }}`
* `{{ LDAP_READONLY_USER_PASSWORD_ENCRYPTED }}`

The ldif files can then be loaded into the `/container/service/slapd/assets/config/bootstrap/ldif/` folder as a volume mount.

Once running we can execute the below in order to query and check success of the seed data:

```
# replace `supermansucks` with whatever you define as the admin password
# in the LDAP_ADMIN_PASSWORD environment variables
docker exec ldap ldapsearch -x -H ldap://localhost -b dc=xmansion,dc=local -D "cn=admin,dc=xmansion,dc=local" -w supermansucks
```

The output should look like this.

```
# extended LDIF
#
# LDAPv3
# base <dc=xmansion,dc=local> with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# xmansion.local
dn: dc=xmansion,dc=local
objectClass: top
objectClass: dcObject
objectClass: organization
o: Mancave Inc.
dc: xmansion

# admin, xmansion.local
dn: cn=admin,dc=xmansion,dc=local
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator
userPassword:: e1NTSEF9NDdQbXNSc2VOVHVaU2hGeUh5RXYzbFI3cE1DejFtUkc=

# search result
search: 2
result: 0 Success

# numResponses: 3
# numEntries: 2
```