#!/bin/bash

az container create \
    --resource-group your-resource-group \
    --name ors-app-croatia \
    --image vmandic/ors-app-croatia:latest \
    --dns-name-label ors-app-croatia-$(date +%s) \
    --ports 8080 \
    # --azure-file-volume-account-name your-storage-acc-name \
    # --azure-file-volume-account-key your-storage-acc-key \
    # --azure-file-volume-share-name your-file-share-that-can-have-pbf-and-conf-or-grpahs \
    # --azure-file-volume-mount-path /ors-conf \
    --cpu 4 \
    --memory 12 \
    --restart-policy OnFailure