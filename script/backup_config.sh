#!/bin/bash

uid=$(id -u)
gid=$(id -g)

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
backup_dir="$(dirname "$script_dir")/backup"

kong_backup_file="$backup_dir/kong.yaml"

echo "Script directory: $script_dir"
echo "backup directory: $backup_dir"
echo "kong_backup_file: $kong_backup_file"

# If backup folder doesn't exist, create it.
if [ ! -d "$backup_dir" ]; then
  echo ""$backup_dir" does not exist."
  mkdir "$backup_dir"
else 
  echo ""$backup_dir" exists."
fi

# if file exits, delete it
# TODO(namnh): such a stupid method!!! Refactor it when
# having time.
if [ -f $kong_backup_file ]; then
  rm -rf $kong_backup_file
  echo "$kong_backup_file is removed"
fi

# create backup kong configuration file.
# if [ ! -d "$backup_dir" ] || [ ! -f "$kong_backup_file" ]; then
  docker run \
  -v $backup_dir:/deck \
  --network oauth2-authen_kong-net \
  kong/deck \
  --kong-addr http://kong-gateway:8001 \
  gateway dump \
  -o /deck/kong.yaml
# fi