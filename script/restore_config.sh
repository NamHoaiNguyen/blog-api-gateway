script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
backup_dir="$(dirname "$script_dir")/backup"

docker run \
-v $backup_dir:/deck \
--network blog-backend-network \
kong/deck \
--kong-addr http://kong-gateway:8001 \
gateway sync \
/deck/kong.yaml