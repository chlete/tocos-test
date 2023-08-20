#!/bin/bash

#Retrieve images
docker pull prom/prometheus:latest
docker pull grafana/grafana-oss:latest

# Run - On the Docker desktop host, add the config files to /tmp. They will be sourced from there and copied
# into the respective containers

# Start Prometheus
docker run --rm --name my-prometheus   --mount type=bind,source=/tmp/prometheus.yml,destination=/etc/prometheus/prometheus.yml --publish 9090:9090  --detach prom/prometheus

# Start Grafana
# Grafana needs to be manually configured via the web interface to add the datasource (prometheus) and import the json dashboad confiuration which wil create docker monitoring dashboard
docker run --rm --name grafana  --publish 3000:3000 --detach grafana/grafana-oss:latest


