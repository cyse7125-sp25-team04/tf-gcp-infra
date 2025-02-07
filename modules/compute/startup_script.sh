#!/bin/bash

echo ******************* Setup kubectl *******************
sudo apt-get update
sudo apt-get install -y kubectl

sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin