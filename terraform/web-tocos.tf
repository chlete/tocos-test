resource "aws_instance" "web" {
  ami           = "ami-df5de72bdb3b" #localstack docker image; when in aws use minimal amazon linux image
  instance_type = "t2.micro"
  subnet_id                   = aws_subnet.tocos-public_subnet.id
  vpc_security_group_ids      = [aws_security_group.tocos-security_group.id]
  associate_public_ip_address = true
  key_name = "pepino"
  ser_data = <<-EOL
  #!/bin/bash -xe

   apt update
   apt-get -y install ca-certificates curl gnupg
   install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null
   apt-get update 
   apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   dockerd & 
  EOL

  tags = {
    Name = "Tocos-web"
  }
}

provider "aws" {
  region                      = "us-east-1"
  #s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4567"
    cloudformation = "http://localhost:4581"
    cloudwatch     = "http://localhost:4582"
    #dynamodb       = "http://localhost:4569"
    es             = "http://localhost:4578"
    firehose       = "http://localhost:4573"
    iam            = "http://localhost:4593"
    kinesis        = "http://localhost:4568"
    lambda         = "http://localhost:4574"
    route53        = "http://localhost:4580"
    redshift       = "http://LOCALHOST:4577"
    s3             = "http://localhost:4572"
    secretsmanager = "http://localhost:4584"
    #ses            = "http://localhost:4579"
    #sns            = "http://localhost:4575"
    #sqs            = "http://localhost:4576"
    #ssm            = "http://localhost:4583"
    stepfunctions  = "http://localhost:4585"
    sts            = "http://localhost:4592"
    ec2            = "http://localhost:4597"

  }
}