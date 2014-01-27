#!/bin/bash
# Run the UpgradeYa docker registry

# Get the last Container Name for the registry
CONTAINER_NAME=$(etcdctl get %project_name%/name)

echo "$(date): Starting registry with volumes from $CONTAINER_NAME" >>  %shared_project_path%/registry.log

# Create a new name for the new container
RANDOM_CHUNK=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c3;echo;)
NEW_NAME="%project_name%_$RANDOM_CHUNK"

# Remember name for other connecting to volume
etcdctl set %project_name%/name $NEW_NAME

# Start registry for systemd
/usr/bin/docker run -p 5000:5000 --volumes-from=$CONTAINER_NAME -name $NEW_NAME upgradeya/%project_name%
