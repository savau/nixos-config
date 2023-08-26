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
        "app.shield.optoutstudies.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.contentblocking.category" = "custom";
        "browser.discovery.enabled" = false;
        "browser.download.autohideButton" = false;
        "browser.formfill.enable" = false;
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.pinned" = "[]";
        "browser.privatebrowsing.autostart" = true;
        "browser.search.suggest.enabled.private" = true;
        "browser.startup.homepage" = "about:blank";
        "browser.tabs.inTitlebar" = 0;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.topsites.contile.cachedTiles" = "[]";
        "browser.topsites.contile.cacheValidFor" = 999999999999;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.placeholderName.private" = "DuckDuckGo";
        "browser.urlbar.quicksuggest.engines" = false;
        "browser.urlbar.quicksuggest.history" = false;
        "browser.urlbar.quicksuggest.openpage" = false;
        "browser.urlbar.quicksuggest.topsites" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "dom.security.https_only_mode" = true;
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
        "permissions.default.camera" = 2;
        "permissions.default.geo" = 2;
        "permissions.default.microphone" = 2;
        "permissions.default.notifications" = 2;
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
        darkreader
        ghostery
        keepassxc-browser
        ublock-origin
      ];
    };
  };
}
