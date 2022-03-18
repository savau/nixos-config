{ config, pkgs, lib, machine, ... }:

let
  defaultUser = rec {
    isNormalUser = true;   # is this user a human?       (i.e. 1000 <= uid <= 60000: create home, show in login dialog, etc.)
    isSystemUser = false;  # is this user a system user? (i.e. 100  <= uid <  500)
    extraGroups  = if defaultUser.isNormalUser then [
      "audio"              # access the PulseAudio server
      "lp"                 # enable and use printers
      "networkmanager"     # configure networks
      "scanner"            # enable and use scanners
      "video"              # control screen brightness
    ] else [];
  };
  additionalPermissions = [
    "docker"               # use docker command without sudo
    "libvirtd"             # can run virtual machines
    "systemd-journal"      # can access systemd journal
    "vboxusers"            # can use VirtualBox
    "wheel"                # system administrator privileges
  ];
in
{
  imports = [
    ./data.nix
  ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  users = {
    extraUsers.root.shell = machine.systemShell;
    
    users = lib.mapAttrs (username: user: {
      uid = if user ? uid then user.uid else null;
      description = if user ? displayName then user.displayName else username;
      isNormalUser = user ? type && user.type == "normal" || defaultUser.isNormalUser;
      isSystemUser = user ? type && user.type == "system" || defaultUser.isSystemUser;
      shell = if user ? shell && user.shell != null then user.shell else machine.systemShell;
      extraGroups = lib.filter (perm: !(lib.elem perm (if user?permissions && user.permissions?exclude then user.permissions.exclude else []))) (
        defaultUser.extraGroups ++ (
          if user ? permissions
          then
            if user.permissions ? all && user.permissions.all
            then additionalPermissions
            else
              if user.permissions ? groups
              then lib.filter (perm: lib.elem perm user.permissions.groups) additionalPermissions
              else []
          else []
        )
      );
    }) machine.users;
  };
}
