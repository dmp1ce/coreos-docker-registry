#!/bin/bash
# Stop the UpgradeYa docker registry

# Get the last Container Name for the registry
CONTAINER_NAME=$(etcdctl get %project_name%/name)

echo "$(date): Stopping registry $CONTAINER_NAME"

# Start registry for systemd
/usr/bin/docker stop $CONTAINER_NAME
