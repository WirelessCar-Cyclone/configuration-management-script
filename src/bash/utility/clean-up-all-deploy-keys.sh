#!/usr/bin/env bash

TOKEN='<github_token>'

readarray -t REPOS < <(curl -s -H "Accept: application/vnd.github.nebula-preview+json" -H "Accept: application/vnd.github.baptiste-preview+json" -H "Content-Type: application/json" -H "Authorization: token ${TOKEN}"  -X GET https://api.github.com/orgs/WirelessCar-Cyclone/repos | jq -r '.[].name')

for REPO in "${REPOS[@]}"
do
    printf '%s\n' "${REPO}"
    readarray -t KEYS < <(curl -s -H "Accept: application/vnd.github.nebula-preview+json" -H "Accept: application/vnd.github.baptiste-preview+json" -H "Content-Type: application/json" -H "Authorization: token ${TOKEN}"  -X GET https://api.github.com/repos/WirelessCar-Cyclone/"${REPO}"/keys | jq -r '.[].id')
   for KEY in "${KEYS[@]}"
   do
        curl -H "Accept: application/vnd.github.nebula-preview+json" -H "Accept: application/vnd.github.baptiste-preview+json" -H "Content-Type: application/json" -H "Authorization: token ${TOKEN}"  -X DELETE https://api.github.com/repos/WirelessCar-Cyclone/"${REPO}"/keys/"${KEY}"
   done
done
