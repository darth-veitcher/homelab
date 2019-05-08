# Keycloak
To configure Keycloak to work with OpenLDAP we need to login and setup our `ldap` container as a `User Federation` provider.

Key setting as follows:

* `Edit Mode`: WRITABLE
* `Connection URL`: ldap://ldap
* `Users DN`: ou=People,dc=xmansion,dc=local
* `Bind DN`: cn=admin,dc=xmansion,dc=local
* `Bind Credential`: <insert admin password>