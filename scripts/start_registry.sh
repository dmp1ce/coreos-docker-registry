#!/bin/bash
# Run the UpgradeYa docker registry

# Get the last Container Name for the registry
if [ -f %shared_project_path%/registry-name ]; then
  CONTAINER_NAME=$(cat %shared_project_path%/registry-name)
fi

echo "$(date): Starting registry with volumes from $CONTAINER_NAME" >>  %shared_project_path%/registry.log

# Create a new name for the new container
RANDOM_CHUNK=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c3;echo;)
NEW_NAME="registry_$RANDOM_CHUNK"

# Remember name for other connecting to volume
echo $NEW_NAME > %shared_project_path%/registry-name

# Start registry for systemd
/usr/bin/docker run -p 5000:5000 --volumes-from=$CONTAINER_NAME -name $NEW_NAME upgradeya/registry
