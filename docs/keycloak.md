# Keycloak
To configure Keycloak to work with OpenLDAP we need to login and setup our `ldap` container as a `User Federation` provider.

Key setting as follows:

* `Vendor`: Other
* `Edit Mode`: WRITABLE
* `Connection URL`: ldap://ldap
* `Users DN`: ou=People,dc=xmansion,dc=local
* `Bind DN`: cn=admin,dc=xmansion,dc=local
* `Bind Credential`: <insert admin password>

We bootstrap this into Keycloak via the [Importing a realm](https://github.com/jboss-dockerfiles/keycloak/tree/master/server#importing-a-realm) option. The easiest way to get this back out of the system is to go the `Export` setting and then get the JSON output.

Unfortunately, due to the way in which the image is configured, the given method in the docs doesn't work (as volumes are mounted by `root` yet the application executes as the `jboss` user and therefore can't access the files). As a result we inherit from and build a custom image with a `/realms` folder that we can mount the JSON files into.