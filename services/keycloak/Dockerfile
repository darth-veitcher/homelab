FROM jboss/keycloak

# HACK: Required so that we can read the files
USER root
RUN mkdir /realms && chown -R jboss:jboss /realms
ADD realms /realms

# HACK: Set timezone manually
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Reset
USER 1000