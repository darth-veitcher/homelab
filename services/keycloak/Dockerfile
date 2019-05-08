FROM jboss/keycloak

# Hack: Required so that we can read the files
USER root
RUN mkdir /realms && chown -R jboss:jboss /realms
ADD realms /realms

# Reset
USER 1000