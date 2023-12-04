script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
backup_dir="$(dirname "$script_dir")/backup"

docker run -i \
-v $backup_dir:/deck \
--network oauth2-authen_kong-net \
kong/deck \
--kong-addr http://kong-gateway:8001 \
gateway reset