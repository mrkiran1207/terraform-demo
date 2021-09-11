provider "azurerm" {
		subscription_id = "3fd51abc-3324-4b73-ba94-b31523517c41"
		client_id = "4d9ff00d-7ec4-49cc-a83c-e46add9e300f"
		client_secret = "PsTE8~J63Eut-zt9B3nOP.3901W_b3wFO9"
		tenant_id = "531b69ad-d219-4725-a625-9a26ca1f167e" 
}

resource "azurerm_resource_group" "resource_group_terraform" {
  name     = "terraform_resource_group"
  location = "East US"
}

resource "azurerm_app_service_plan" "app_service_plan_terraform" {
  name                = "terraform-appserviceplan"
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service_terraform" {
  name                = "app-service-terraform-2020"
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan_terraform.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
