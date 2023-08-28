{ lib, pkgs, home, ... }:

{
  programs.thunderbird = {
    enable = true;

    profiles.default = {
      isDefault = true;
      settings = {
        "browser.display.use_system_colors" = true;
        "browser.underline_anchors" = false;
        "calendar.alarms.playsound" = true;
        "calendar.alarms.show" = true;
        "calendar.alarms.showmissed" = false;
        "calendar.view.dayendhour" = 22;
        "calendar.view.showLocation" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "intl.date_time.pattern_override.date_short" = "yyyy-MM-dd";
        "intl.date_time.pattern_override.date_medium" = "yyyy-MM-dd";
        "intl.date_time.pattern_override.date_long" = "yyyy-MM-dd";
        "intl.date_time.pattern_override.date_full" = "yyyy-MM-dd";
        "intl.date_time.pattern_override.time_short" = "HH:mm";
        "intl.date_time.pattern_override.time_medium" = "HH:mm";
        "intl.date_time.pattern_override.time_long" = "HH:mm";
        "intl.date_time.pattern_override.time_full" = "HH:mm";
        "intl.date_time.pattern_override.connector_short" = " ";
        "mail.compose.default_to_paragraph" = false;
        "mail.purge.ask" = false;
        "mail.startup.enabledMailCheckOnce" = true;
        "mailnews.start_page.enabled" = false;
        "msgcompose.font_face" = "monospace";
        "network.cookie.cookieBehavior" = 3;
        "places.history.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "spellchecker.dictionary" = "en-US,de-DE";
      };
    };
  };
}
