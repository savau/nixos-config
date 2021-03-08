{ config, pkgs, lib, machine, ... }:

with lib;

let
  basicPermissions = [
    "audio"
    "video"
    "networkmanager"
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
    
    users = mapAttrs (_: user: {
      uid = user.id;
      description = user.displayName;
      isNormalUser = true;
      shell = if user.shell == null then machine.systemShell else user.shell;
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
