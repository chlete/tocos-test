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


# Assumptions
 Since the microservice image is hosted at docker hub, and the github actions are located on the internet, the deployment step would require to trigger the `docker pull` on the "EC2" instance running locally, which is not possible (or I couldnt find a way) Therefore is mocked only.

 # Design
- **Microservice**: Simple RESTful API written in python which will return in a json, a list of users and coins. A Unit test was written too.
- ***Container***: Tocos image located at `https://hub.docker.com/repository/docker/zvedzo/tocos/general`, runs without root privs, to lower the impact of a possible bug exploitation. Additionally, the image used, was a minimal one with `alpine + python 3.10`, in order to optimise the resources and reduce the attack surface.
- ***CI/CD Pipeline***: Github Action was the choice, due to it's simplicity. 
- ***Underlying infrastructure***: Emulation of EC2, VPC with separation of private and public subnets. To expose only what is needed on the internet. All the infrastructure is created with Terraform.
- ***Monitoring***: Prometheus and Granfana are installed as containers in Docker. 

# Workflow
- Installation: Terraform will create the necessary infrastructure on the first run, on which the microserve is also deployed.
- Development: The developer will push the code and trigger a github action, which will trigger unit tests and later build, and push the image to the Docker Hub registry.

# Directory structure

.
├── Dockerfile
├── README.md
├── prometheus.yml
├── requirements.txt
├── scripts
│   ├── docker-dashboard-grafana.json
│   └── setup-prometheus-grafana.sh
├── terraform
│   ├── network-tocos.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── variables.tf
│   └── web-tocos.tf
└── tocos-api
    ├── requirements.txt
    ├── tocoscredits.py
    └── unit-test.py




