#!/usr/bin/env bash

az login --service-principal -u "${SERVICE_PRINCIPAL_ID}" -p "${SERVICE_PRINCIPAL_PASSWD}" --tenant "${SERVICE_PRINCIPAL_TENANT}"

for VAULT_NAME in 'qa-weu-kv' 'qa-neu-kv'
do
    printf '%s\n' "${VAULT_NAME}"
    readarray -t CERTS < <(az keyvault certificate list --vault-name "${VAULT_NAME}" | jq -r '.[].id')

    for CERT in "${CERTS[@]}"
    do
        az keyvault certificate delete --id "${CERT}" --vault-name ${VAULT_NAME}
    done
done
