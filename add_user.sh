#!/usr/bin/env bash
user=${1:-host}
password=${2:-$(pwgen)}
docker exec -it jitsi_prosody prosodyctl --config /config/prosody.cfg.lua register "$user" meet.jitsi "$password"
echo $user:$password

