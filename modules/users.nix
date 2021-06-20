{ config, pkgs, lib, machine, ... }:

with lib;

let
  defaultUser = rec {
    isNormalUser = true;  # is this user a human? (i.e. uid >= 1000: create home, show in login dialog, etc.)
    extraGroups  = if defaultUser.isNormalUser then [
      "audio"             # access the PulseAudio server
      "lp"                # enable and use printers
      "networkmanager"    # configure networks
      "scanner"           # enable and use scanners
      "video"             # control screen brightness
    ] else [];
  };
  additionalPermissions = [
    "docker"           # use docker command without sudo; TODO: add flag
    "libvirtd"         # can run virtual machines; TODO: add flag
    "systemd-journal"  # can access systemd journal; TODO: add to admin flag
    "vboxusers"        # can use VirtualBox; TODO: add flag
    "wheel"            # su; TODO: add admin flag
  ];
in
{
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  users = {
    extraUsers.root.shell = machine.systemShell;
    
    users = mapAttrs (username: user: {
      uid = if user ? uid then user.uid else null;
      description = if user ? displayName then user.displayName else username;
      isNormalUser = user ? type && user.type == "normal" ||  defaultUser.isNormalUser;
      isSystemUser = user ? type && user.type == "system" || !defaultUser.isNormalUser;
      shell = if user ? shell && user.shell != null then user.shell else machine.systemShell;
      extraGroups = defaultUser.extraGroups ++ (
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
