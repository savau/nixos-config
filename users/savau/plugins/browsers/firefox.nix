{ lib, pkgs, home, ... }:

let
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };
in
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      settings = {
        "browser.download.autohideButton" = false;
        "browser.formfill.enable" = false;
        "browser.newtabpage.enabled" = false;
        "browser.privatebrowsing.autostart" = true;
        "browser.search.suggest.enabled.private" = true;
        "browser.startup.homepage" = "about:blank";
        "browser.topsites.contile.cachedTiles" = "[]";
        "browser.uiCustomization.state" = "{\"placements\":{\"nav-bar\":[\"back-button\",\"forward-button\",\"urlbar-container\",\"bookmarks-menu-button\",\"downloads-button\",\"unified-extensions-button\"]}}";
        "browser.urlbar.quicksuggest.engines" = false;
        "browser.urlbar.quicksuggest.history" = false;
        "browser.urlbar.quicksuggest.openpage" = false;
        "browser.urlbar.quicksuggest.topsites" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "dom.security.https_only_mode" = true;
        "permissions.default.camera" = 2;
        "permissions.default.geo" = 2;
        "permissions.default.microphone" = 2;
        "permissions.default.xr" = 2;
        "places.history.enabled" = false;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "signon.autofillForms" = false;
        "signon.rememberSignons" = false;
      };

      search = {
        default = "DuckDuckGo";
        order = [ "DuckDuckGo" ];
        force = true;
      };

      extensions = with nur.repos.rycee.firefox-addons; [
        behind-the-overlay-revival
        darkreader
        forget_me_not
        ghostery
        keepassxc-browser
        ublock-origin
      ];
    };
  };
}
