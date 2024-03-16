#!/bin/bash
set -e

TEAM_NAME=$1
ACR_NAME=$2
DOMAIN_NAME=$3

IMAGE_TAG="latest"
PROJECT_NAME="server"
CLUSTER_NAME="team"

REPO_NAME="${ACR_NAME}.azurecr.io"
IMAGE_NAME="${TEAM_NAME}/${PROJECT_NAME}"

# Log into the ACR
az acr login --name $ACR_NAME
# Build the image
docker build -t $IMAGE_NAME:$IMAGE_TAG .
docker tag $IMAGE_NAME:$IMAGE_TAG $REPO_NAME/$IMAGE_NAME:$IMAGE_TAG
# Push the image to the ACR
docker push $REPO_NAME/$IMAGE_NAME:$IMAGE_TAG
# Retrieve kubernetes credentials / add them to .kubeconfig
# Deploy or upgrade helm charts
helm install $TEAM_NAME-helm team/ --values team/values.yaml
