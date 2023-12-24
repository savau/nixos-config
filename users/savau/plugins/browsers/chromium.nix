{ lib, pkgs, home, ... }:

{
  programs.chromium = {
    enable = true;

    commandLineArgs = [
      "--disable-gpu-driver-bug-workarounds"
    ];

    extensions = [
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "mlomiejdfkolichcflejclcbmpeaniij"; } # Ghostery
      { id = "oboonakemofpalcgghocfoadofidjkkk"; } # KeePassXC-Browser
      { id = "doojmbjmlfjjnbmnoijecmcbfeoakpjm"; } # NoScript
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    ];
  };
}
