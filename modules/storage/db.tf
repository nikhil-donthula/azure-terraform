resource "azurerm_cosmosdb_account" "cosmos_db" {
  name                = "${var.team}-${var.environment}-cosmosdb"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  offer_type          = "Standard"
  kind                = "MongoDB"


  enable_free_tier = true 
  public_network_access_enabled = true

  #for azure portal access add 104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26
  ip_range_filter = "20.198.103.194,72.36.32.105"

  capacity {
    total_throughput_limit = 1000
  }

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location            = var.resource_group.location
    failover_priority = 0
  }

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "mode11" {
  name                = "modeelevendb"
  resource_group_name = var.resource_group.name
  account_name        = azurerm_cosmosdb_account.cosmos_db.name

  autoscale_settings {
    max_throughput = 1000
  }

  timeouts {
    create = "30m"
    update = "30m"
    read   = "5m"
    delete = "30m"
  }
}

#private_endpoint
resource "azurerm_private_endpoint" "cosmosdb-pendp" {
  name                = "${var.team}-${var.environment}-cosmosdb-pendp"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  subnet_id           = var.private_subnet.id

  private_service_connection {
    name                            = "${var.team}-${var.environment}-cosmosdb-service-connection"
    private_connection_resource_id  = azurerm_cosmosdb_account.cosmos_db.id
    is_manual_connection            = false
    subresource_names               = ["MongoDB"]
  }

  tags = var.tags
}