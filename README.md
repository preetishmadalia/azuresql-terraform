# azuresql-terraform
Azure terraform projects to automate database deployments. In this project we deploy MS SQL database and implement database initialization scripts such as data account creation and assign roles.

Pre-requisites :
1. Need Azure CLI installed on your local device.
2. Need Terraform installed on your local device.
3. Azure Subscription
4. Azure Resource Group
5. Azure KeyVault set up

Steps to execute :
 Below steps will work on any of the projects in this repo.

 terraform init
 terraform plan
 terraform apply -auto-approve
 terraform destroy -auto-approve

<i>terraform init</i> initializes all the providers refereenced in the script.

<i>terraform plan</i> will show any possible errors in the scripts. Fix the scripts if there are any errors before moving forward.

<i>terraform apply -auto-approve</i> creates all the resources defined in scripts on your Azure resource group.

<i>terraform destroy -auto-approve</i> deletes all the resources defined in scripts on your Azure resource group.


## mssql-database
Refer to this folder for a single database deployment. Deploys a database server and a MS SQL database in your pre-defined resource group in singe region.

Populate variables defined in <i>terraform.tfvars</i> file.

You also replace database init scripts under */scripts/* folder and make necessary changes in main.tf file.

## mssql-db-failover-grp
Refer to this folder for a database deployment with failover group configuration. Deploys a database server and a MS SQL database in primary and secondary region. Database will be deployed only in primary region. With failover group enabled, database will automatically get deployed to secondary server. You can use this configration for deployment in same or different region. Script also implements database initialization scripts.

Populate variables defined in <i>terraform.tfvars</i> file.

You also replace database init scripts under */scripts/* folder and make necessary changes in main.tf file.

https://docs.microsoft.com/en-us/samples/azure-samples/azure-sql-db-ci-cd/azure-sql-db-ci-cd/
