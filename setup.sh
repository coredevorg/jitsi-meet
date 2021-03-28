#!/usr/bin/env bash
[ "$1" ] || { echo "usage: ./setup.sh <FQDN>" 1>&2 ; exit 1 ; }
VIRTUAL_HOST="$1"
mkdir -p ./data/{web/letsencrypt,transcripts,prosody/config,prosody/prosody-plugins-custom,jicofo,jvb,jigasi,jibri}
[ -f ".env" ] || cp env.nginx-proxy .env
sed -i "s/{{VIRTUAL_HOST}}/${VIRTUAL_HOST}/g" .env
./gen-passwords.sh
echo -n "continue with startup? " && read dummy
docker-compose -f docker-compose.yml up -d --build
LOGIN=$(./add_user.sh)
echo "use [$LOGIN] to start jitsi-meet host session"
echo "run $PWD/add_user.sh to change/add host users"
echo -n "show startup logs? " && read dummy
docker-compose -f docker-compose.yml logs -f --tail 1000
