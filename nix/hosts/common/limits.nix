# gaming related configs from arch wiki
{ username }:
{
  security.pam.loginLimits = [
    { domain = username; type = "soft"; item = "nofile"; value = "524288"; }
    { domain = username; type = "hard"; item = "nofile"; value = "524288"; }
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
}
