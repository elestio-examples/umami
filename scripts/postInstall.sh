#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
# sleep 30s;

target=$(docker-compose port umami 3000)

login=$(curl http://${target}/api/auth/login \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'authorization: Bearer undefined' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/json' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36' \
  -H 'x-umami-share-token: undefined' \
  --data-raw '{"username":"admin","password":"umami"}' \
  --compressed)

token=$(echo $login | jq -r '.token')

curl http://${target}/api/me/password \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'authorization: Bearer '${token}'' \
  -H 'cache-control: max-age=0' \
  -H 'content-type: application/json' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36' \
  -H 'x-umami-share-token: undefined' \
  --data-raw '{"currentPassword":"umami","newPassword":"'${ADMIN_PASSWORD}'","confirmPassword":"'${ADMIN_PASSWORD}'"}' \
  --compressed
