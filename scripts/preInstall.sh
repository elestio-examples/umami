set env vars
set -o allexport; source .env; set +o allexport;

newPassword=$(mkpasswd -m bcrypt "${ADMIN_PASSWORD}")

sed -i "s~PASSWORD~${newPassword}~g" ./sql/schema.postgresql.sql