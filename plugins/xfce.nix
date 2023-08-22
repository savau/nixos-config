{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; with pkgs.xfce; [
    xfce4-session

    xfce4-power-manager

    # xfce-panel
    autoconf automake pkg-config # needed for xmonad integration with xfce4-panel # TODO: maybe move to xmonad nix file and integrate that one?
    xfce4-panel
    xfce4-panel-profiles    # simple application to manage xfce panel layouts
    xfce4-battery-plugin    # battery plugin for xfce panel
    xfce4-clipman-plugin    # clipboard manager plugin for xfce panel
    xfce4-datetime-plugin   # shows the date and time in the panel, and a calendar appears when you left-click on it
    xfce4-mailwatch-plugin  # mail watcher plugin for xfce panel
    xfce4-cpugraph-plugin   # CPU graph show for xfce panel
    xfce4-genmon-plugin     # generic monitor plugin for xfce panel
    xfce4-systemload-plugin # system load plugin for xfce panel
    xfce4-fsguard-plugin    # filesystem usage monitor plugin for xfce panel
    xfce4-netload-plugin    # internet load speed plugin for xfce panel
    # xfce4-embed-plugin    # embed arbitrary app windows on xfce panel (currently marked as broken)

    # pulseaudio
    # xfce4panel_gtk3  # required for pulseaudio, see https://github.com/NixOS/nixpkgs/issues/18724
    xfce4-pulseaudio-plugin
    xfce4-volumed-pulse

    # thunar
    thunar
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-volman
    tumbler # thunar thumbnails
    xfconf  # thunar save settings
  ];
}
