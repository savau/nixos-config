{ lib, pkgs, home, ... }:

{
  programs.chromium = {
    enable = true;

    commandLineArgs = [
      "--disable-gpu-driver-bug-workarounds"
    ];

    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "mlomiejdfkolichcflejclcbmpeaniij"; } # Ghostery
      { id = "oboonakemofpalcgghocfoadofidjkkk"; } # KeePassXC-Browser
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "doojmbjmlfjjnbmnoijecmcbfeoakpjm"; } # NoScript
    ];
  };
}
