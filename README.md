# Tocos test

## Pre-requisites

This was run on a MacOS system.
The following binaries are installed
- Localstack 
- tflocal can be installed:
```
pip install terraform-local
```
- Docker

 # Design
- **Microservice**: Simple RESTful API written in python which will return in a json, a list of users and coins. A Unit test was written too.
- ***Container***: Tocos image located at `https://hub.docker.com/repository/docker/zvedzo/tocos/general`, runs without root privs, to lower the impact of a possible bug exploitation. Additionally, the image used, was a minimal one with `alpine + python 3.10`, in order to optimise the resources and reduce the attack surface.
- ***CI/CD Pipeline***: Github Action was the choice, due to it's simplicity.  Since the microservice image is hosted at docker hub, and the github actions are located on the internet, the deployment step would require to trigger the `docker pull` on the "EC2" instance running locally, which is not possible (or I couldnt find a way) Therefore is mocked only.
- ***Underlying infrastructure***: Emulation of EC2, VPC with separation of private and public subnets. To expose only what is needed on the internet. All the infrastructure is created with Terraform.
- ***Monitoring***: Prometheus and Granfana are installed as containers in Docker. 

# Workflow
- Installation: Terraform will create the necessary infrastructure on the first run, on which the microserve is also deployed.
- Development: The developer will push the code and trigger a github action, which will trigger unit tests and later build, and push the image to the Docker Hub registry.

# Directory structure
Dockerfile how the image of the microservice should be built.
scripts/ contains `setup-prometheus-grafana.sh` the installation script for prometheus and grafana, as containers. This file is located on the web, which is retrieved on the installation step. Additionally, there is a definition of `docker-dashboard-grafana.json` used for the Grafana dashboard.
terraform/ contains the scripts that set up the infrastructure.
tocos-api/ source of the microservice along with the unit test.

# How to run it
Assumptions: localstack is running.
First, run the terraform script
`cd terraform && tflocal init && tflocal plan && tflocal apply`








