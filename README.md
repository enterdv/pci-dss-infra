# terraform and ansible scripts for provision PSI-DSS Compliant Infrastructure

#### Requirements

* terraform >= 0.12
* terragrunt >= 0.12
* ansible
* `aws_access_key_id` & `aws_secret_access_key` 

#### Infrastructure Components
##### EC2 Instances:
* `bastion` for ssh access to other components
* `public-nginx` frontend server
* `app` backend application server

##### RDS:
* RDS DataBase for application
pci
##### AWS Elasticsearch Service
* Elasticsearch Domain for Log Collecting

##### AWS GuardDuty
* AWS GuardDuty as IPS/IDS

#### terragrunt example

```shell script
cd terraform/10-common/
terragrunt apply
```

#### ansible example

```shell script
ansible-playbook -i inventory/ playbook.yml  -D --key-file ~/.ssh/private_key.pem
```