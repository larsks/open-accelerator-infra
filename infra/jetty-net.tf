resource "openstack_networking_network_v2" "jetty-net" {
  provider       = openstack.admin
  tenant_id      = data.openstack_identity_project_v3.open-accelerator.id
  name           = "jetty-net"
  admin_state_up = true
  shared         = true

  segments {
    network_type     = "vlan"
    segmentation_id  = 218
    physical_network = "datacentre"
  }
}

data "openstack_networking_network_v2" "external_network" {
  name = "external"
}

resource "openstack_networking_subnet_v2" "jetty-subnet" {
  provider   = openstack.admin
  tenant_id  = data.openstack_identity_project_v3.open-accelerator.id
  name       = openstack_networking_network_v2.jetty-net.name
  network_id = openstack_networking_network_v2.jetty-net.id
  cidr       = "10.20.16.0/23"
  ip_version = 4
  dns_nameservers = [
    "8.8.8.8",
    "8.8.4.4",
  ]

  allocation_pool {
    start = "10.20.16.10"
    end   = "10.20.16.255"
  }
}

resource "openstack_networking_router_v2" "jetty-router" {
  name                = openstack_networking_network_v2.jetty-net.name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external_network.id
}

resource "openstack_networking_router_interface_v2" "jetty-router-interface" {
  router_id = openstack_networking_router_v2.jetty-router.id
  subnet_id = openstack_networking_subnet_v2.jetty-subnet.id
}

resource "openstack_networking_router_interface_v2" "jetty-router-ports" {
  router_id = openstack_networking_router_v2.jetty-router.id
  port_id   = openstack_networking_port_v2.oac-fw-jetty-port.id
}

resource "openstack_networking_router_route_v2" "jetty-router-routes" {
  router_id        = openstack_networking_router_v2.jetty-router.id
  destination_cidr = "10.20.2.0/23"
  next_hop         = "10.20.0.1"
}
