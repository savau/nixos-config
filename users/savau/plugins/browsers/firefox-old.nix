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
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.contentblocking.category" = "custom";
        "browser.discovery.enabled" = false;
        "browser.display.use_document_fonts" = 0;
        "browser.download.autohideButton" = false;
        "browser.formfill.enable" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.pinned" = "[]";
        "browser.policies.applied" = true;
        "browser.privatebrowsing.autostart" = true;
        "browser.search.region" = "DE";
        "browser.search.suggest.enabled.private" = true;
        "browser.startup.homepage" = "about:blank";
        "browser.tabs.inTitlebar" = 0;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"urlbar-container\",\"bookmarks-menu-button\",\"downloads-button\",\"keepassxc-browser_keepassxc_org-browser-action\",\"addon_darkreader_org-browser-action\",\"firefox_ghostery_com-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"keepassxc-browser_keepassxc_org-browser-action\",\"developer-button\",\"addon_darkreader_org-browser-action\",\"firefox_ghostery_com-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"dirtyAreaCache\":[\"unified-extensions-area\",\"nav-bar\",\"toolbar-menubar\",\"TabsToolbar\",\"PersonalToolbar\"],\"currentVersion\":19,\"newElementCount\":9}";
        "browser.topsites.contile.cachedTiles" = "[]";
        "browser.topsites.contile.cacheValidFor" = 999999999999;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.placeholderName.private" = "DuckDuckGo";
        "browser.urlbar.quicksuggest.engines" = false;
        "browser.urlbar.quicksuggest.history" = false;
        "browser.urlbar.quicksuggest.openpage" = false;
        "browser.urlbar.quicksuggest.scenario" = "history";
        "browser.urlbar.quicksuggest.topsites" = false;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.tipShownCount.searchTip_onboard" = 4;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
        "doh-rollout.doneFirstRun" = true;
        "doh-rollout.home-region" = "DE";
        "dom.forms.autocomplete.formautofill" = true;
        "dom.security.https_only_mode" = true;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.pictureinpicture.enable_picture_in_picture_overrides" = true;
        "extensions.webcompat.enable_shims" = true;
        "extensions.webcompat.perform_injections" = true;
        "extensions.webcompat.perform_ua_overrides" = true;
        "findbar.highlightAll" = true;
        "font.default.x-western" = "sans-serif";
        "font.name.monospace.x-western" = "Liberation Mono";
        "font.name.sans-serif.x-western" = "Liberation Sans";
        "font.name.serif.x-western" = "Liberation Serif";
        "intl.accept_languages" = "de-de,en-us,en";
        "intl.locale.requested" = "en-US,de";
        "intl.regional_prefs.use_os_locales" = true;
        "network.dns.disablePrefetch" = true;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
        "pdfjs.enabledCache.state" = false;
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
        "privacy.history.custom" = true;
        "services.sync.clients.devices.desktop" = 1;
        "services.sync.clients.devices.mobile" = 1;
        "services.sync.username" = "sarah.vaupel@pm.me";
        "signon.autofillForms" = false;
        "signon.rememberSignons" = false;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
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
