package terraform

import input.tfplan as tfplan

allowed_platforms = ["aws", "azurerm", "google"]
deny_platforms = ["openstack", "vmware"]

res := tfplan.resource_changes



# Check only allowed clouds
deny[msg] {
    r = res[_]
    deny_platforms[_] == r.provider_name
    msg := sprintf("Provider %s is not allowed", [r.provider_name])
}

