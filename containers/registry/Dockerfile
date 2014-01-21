FROM registry

# Define configuration file in a persistant volume
RUN mkdir /data && mv /docker-registry/config.yml /data && ln -s /data/config.yml /docker-registry
VOLUME ["/data"]
