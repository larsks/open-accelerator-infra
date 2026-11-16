from ansible.inventory.helpers import get_group_vars
from ansible.plugins.inventory import BaseInventoryPlugin
from ansible.utils.vars import combine_vars

DOCUMENTATION = """
    name: bmcs
    plugin_type: inventory
    short_description: Creates per-bmc groups from bmc_type and bmc_addr variables
    description:
        - Scans existing inventory and creates a host group per bmc_type value,
          using bmc_addr values as host entries.
"""


class InventoryModule(BaseInventoryPlugin):
    NAME = "bmcs"

    def verify_file(self, path):
        return super().verify_file(path) and path.endswith((".yaml", ".yml"))

    def parse(self, inventory, loader, path, cache=True):
        super().parse(inventory, loader, path, cache)

        group = self.inventory.add_group("_bmcs")

        for host in list(self.inventory.hosts):
            host_obj = self.inventory.get_host(host)
            merged_vars = combine_vars(
                get_group_vars(host_obj.get_groups()), host_obj.get_vars()
            )

            if merged_vars.get("bmc_type") and merged_vars.get("bmc_addr"):
                bmc_addr = merged_vars.get("bmc_addr")
                self.inventory.add_host(bmc_addr, group)
                self.inventory.set_variable(
                    bmc_addr,
                    "ansible_user",
                    merged_vars.get("bmc_user"),
                )
                self.inventory.set_variable(
                    bmc_addr,
                    "ansible_password",
                    merged_vars.get("bmc_password"),
                )
