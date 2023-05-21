set env vars
set -o allexport; source .env; set +o allexport;

apt install jq -y