#!/usr/bin/env bash

# az login --service-principal -u "${SERVICE_PRINCIPAL_ID}" -p "${SERVICE_PRINCIPAL_PASSWD}" --tenant "${SERVICE_PRINCIPAL_TENANT}"

readarray -t RG_NAMES < <(az group list | jq -r '.[].name')

for RG_NAME in "${RG_NAMES[@]}"
do
    printf '%s\n' "az group delete --no-wait --yes --name ${RG_NAME}"
    az group delete --no-wait --yes --name "${RG_NAME}"
done
