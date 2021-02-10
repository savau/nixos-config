{ config, pkgs, ... }:

{
  services = {
    #openldap = {
    #  enable = true;
    #  rootdn = "cn=admin,dc=example";
    #  rootpw = "rootpw-test";
    #  suffix = "dc=example";
    #};

    postgresql = {
      enable = true;
      identMap = ''
        uniworx uniworx uniworx
      '';
      ensureDatabases = [
        "uniworx"
        "uniworx_test"
      ];
      ensureUsers = [
        {
          name = "uniworx";
          ensurePermissions = {
            "DATABASE uniworx" = "ALL PRIVILEGES";
            "DATABASE uniworx_test" = "ALL PRIVILEGES";
          };
        }
      ];
    };
  };
}
