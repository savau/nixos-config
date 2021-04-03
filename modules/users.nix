{ config, pkgs, lib, machine, ... }:

with lib;

let
  basicPermissions = [
    "audio"
    "video"
    "networkmanager"
    "scanner"
    "lp"
  ];
  additionalPermissions = [
    "wheel"
    "systemd-journal"
    "vboxusers"
    "libvirtd"
    "docker"
  ];
in
{
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  users = {
    extraUsers.root.shell = machine.systemShell;
    
    users = mapAttrs (username: user: {
      uid = user.id;
      description = if user ? displayName then user.displayName else username;
      isNormalUser = true;
      shell = if user ? shell && user.shell != null then user.shell else machine.systemShell;
      extraGroups = basicPermissions ++ (
        if user ? permissions
        then
          if user.permissions ? all && user.permissions.all
          then additionalPermissions
          else
            if user.permissions ? additional
            then filter (perm: elem perm user.permissions.additional) user.permissions.additional
            else []
        else []
      );
    }) machine.users;
  };
}
