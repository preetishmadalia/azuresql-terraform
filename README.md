# azuresql-terraform
Azure Terraform projects to automate database deployments. In this project we deploy Microsoft SQL database and implement database initialization scripts such as data account creation and assign roles.

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


## Pre-requisite Details

### Resource Group
In this example we assume that a resource group already exists so we use the <i>data</i> block. All the resources will be created in this resource group. 

### Azure Key Vault
Create Azure Key Vault to store secrets such as database admin password. The purpose of this is to keep the admin password secure and not provision it at the time of database creation. There may be other patterns through which you can securely store passwords in kay vault. In this example we we use key vault and admin password using <i>data</i> blocks.

## singledb-implementation
Refer to this folder for a single database deployment. Deploys a database server and a MS SQL database in your pre-defined resource group in singe region.

Populate variables defined in <i>terraform.tfvars</i> file.

All the resources to be created at defined in main.tf.

Resources created are :-
1. SQL Server
2. SQL Database with name - DemoDB
3. Extended policy for SQL Server.
4. Extended policy for SQL Database
5. Storage Account to audit database and server policies.

## mssql-db-failover-grp
Refer to this folder for a database deployment with failover group configuration. Deploys a database server and a MS SQL database in primary and secondary region. Database will be deployed only in primary region. With failover group enabled, database will automatically get deployed to secondary server. You can use this configration for deployment in same or different region. Script also implements database initialization scripts.

Populate variables defined in <i>terraform.tfvars</i> file.

You also replace database init scripts under */scripts/* folder and make necessary changes in main.tf file.