#!/usr/bin/env bash
[ "$1" ] || {
    echo "usage: ./setup.sh <FQDN>" 1>&2
    exit 1
}
VIRTUAL_HOST="$1"

mkdir -p ./data/{web/letsencrypt,transcripts,prosody/config,prosody/prosody-plugins-custom,jicofo,jvb,jigasi,jibri}

[ -f ".env" ] || cp env.nginx-proxy .env
sed -i "s/{{VIRTUAL_HOST}}/${VIRTUAL_HOST}/g" .env

./gen-passwords.sh
