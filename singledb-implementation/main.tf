# Configure the Azure provider
provider "azurerm" { 
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you are using version 1.x, the "features" block is not allowed.
    features {}
}

data "azurerm_subscription" "current" {
}

data "azurerm_key_vault" "dbvault" {
  name                = var.vault
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "dbadminuser" {
  name         = "missadministrator"
  key_vault_id = data.azurerm_key_vault.dbvault.id
}

output "secret_value" {
  value = data.azurerm_key_vault_secret.dbadminuser.value
  sensitive   = true
}

/*
* NOTE: Review firewall rules as per your needs. The setp below is not ideal.
*/
resource "azurerm_sql_firewall_rule" "fw" {
  name                = "MyDB-fwrules"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplemydbstacct"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
}

resource "azurerm_sql_server" "example" {
  name                         = "myappdb-mssqlserver"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.dbadminuser.name
  administrator_login_password = data.azurerm_key_vault_secret.dbadminuser.value
  
  tags = {
    foo = "bar"
  }
}

resource "azurerm_mssql_database" "test" {
  name           = "DemoDB"
  server_id      = azurerm_sql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true
  
  tags = {
    foo = "bar"
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "example" {
  server_id                               = azurerm_sql_server.example.id
  storage_endpoint                        = azurerm_storage_account.example.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.example.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

resource "azurerm_mssql_database_extended_auditing_policy" "example" {
  database_id                             = azurerm_mssql_database.test.id
  storage_endpoint                        = azurerm_storage_account.example.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.example.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

