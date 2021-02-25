{ config, pkgs, lib, ... }:

with lib;

let
  mySystemShell = import ../definitions/system-shell.nix;
  myUsers = import ../definitions/users.nix;

  # TODO: replace this with internal additionalGroups list once we have a user type in definitions/users.nix
  myUserAdditionalGroups = [
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
    extraUsers.root.shell = mySystemShell;
    
    users = mapAttrs (_: user: {
      uid = user.id;
      description = user.displayName;
      isNormalUser = true;
      shell = if user.shell == null then mySystemShell else user.shell;
      extraGroups = [
        "audio" "video"
        "networkmanager"
      ] ++ (
        # TODO: move this logic to user type definition in definition/users.nix
        filter (grp: user.permissions.all || user.permissions."${grp}") myUserAdditionalGroups
      );
    }) myUsers;
  };
}
