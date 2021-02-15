{ config, pkgs, lib, ... }:

{
  services = {
    # TODO: do I need this?
    #openldap = {
    #  enable = true;
    #  rootdn = "cn=root,dc=nixos,dc=org";
    #  rootpw = "thereisnopassword";
    #  suffix = "dc=nixos,dc=org";
    #};

    postgresql = {
      enable = true;
      authentication = lib.mkForce ''
        # TYPE  DATABASE  USER  ADDRESS       METHOD
        local   all       all                 trust
        host    all       all   127.0.0.1/32  trust
        host    all       all   ::1/128       trust
      '';
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

  environment.systemPackages = with pkgs; [
    #openldap
    #haskell.packages.ghc8103
    exiftool
  ];
}
