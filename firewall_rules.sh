#!/bin/bash

# Create firewall rule to allow SSH
gcloud compute firewall-rules create allow-ssh \
   --direction=INGRESS \
   --priority=1000 \
   --network=default \
   --action=ALLOW \
   --rules=tcp:22 \
   --source-ranges=0.0.0.0/0

# Create firewall rule to deny all other traffic
gcloud compute firewall-rules create deny-all \
   --direction=INGRESS \
   --priority=2000 \
   --network=default \
   --action=DENY \
   --rules=all \
   --source-ranges=0.0.0.0/0
