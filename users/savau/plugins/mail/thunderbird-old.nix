{ lib, pkgs, home, ... }:

{
  programs.thunderbird = {
    enable = true;

    profiles.default.isDefault = true;
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
      
      # "mail.smtpserver.smtp_uniworx.authMethod" = 0;
      # "mail.smtpserver.smtp_uniworx.clientid" = "02302bd7-e7ed-48d5-b2d6-3d36dcca5323";
      # "mail.smtpserver.smtp_uniworx.description" = "";
      # "mail.smtpserver.smtp_uniworx.hostname" = "mailsub.uniworx.de";
      # "mail.smtpserver.smtp_uniworx.port" = 465;
      # "mail.smtpserver.smtp_uniworx.try_ssl" = 3;
      # "mail.smtpserver.smtp_uniworx.username" = "savau";
      # "mail.smtpserver.smtp_protonmail.authMethod" = 3;
      # "mail.smtpserver.smtp_protonmail.clientid" = "f285f87d-7e03-474c-9283-b1da59c8ccdf";
      # "mail.smtpserver.smtp_protonmail.description" = "ProtonMail";
      # "mail.smtpserver.smtp_protonmail.hostname" = "127.0.0.1";
      # "mail.smtpserver.smtp_protonmail.port" = 1025;
      # "mail.smtpserver.smtp_protonmail.try_ssl" = 2;
      # "mail.smtpserver.smtp_protonmail.username" = "sarah.vaupel@protonmail.com";
      # "mail.smtpserver.smtp_gmail.authMethod" = 10;
      # "mail.smtpserver.smtp_gmail.clientid" = "1abea412-407e-45e1-80e5-c64b20d3c69e";
      # "mail.smtpserver.smtp_gmail.description" = "Google Mail";
      # "mail.smtpserver.smtp_gmail.hostname" = "smtp.gmail.com";
      # "mail.smtpserver.smtp_gmail.oauth2.issuer" = "accounts.google.com";
      # "mail.smtpserver.smtp_gmail.oauth2.scope" = "https://mail.google.com/ https://www.googleapis.com/auth/carddav https://www.googleapis.com/auth/calendar";
      # "mail.smtpserver.smtp_gmail.port" = 465;
      # "mail.smtpserver.smtp_gmail.try_ssl" = 3;
      # "mail.smtpserver.smtp_gmail.username" = "sarah.elisa.vaupel@gmail.com";
      # "mail.smtpservers" = "smtp_uniworx,smtp_protonmail,smtp_gmail";
    };
  };

  accounts.email = {
    accounts =
      let
        settings_template = id: {
          # "mail.server.server_${id}.ageLimit" = 30;
          # "mail.server.server_${id}.applyToFlaggedMessages" = false;
          # "mail.server.server_${id}.check_new_mail" = true;
          # "mail.server.server_${id}.cleanupBodies" = false;
          # "mail.server.server_${id}.daysToKeepBodies" = 30;
          # "mail.server.server_${id}.daysToKeepHdrs" = 30;
          # "mail.server.server_${id}.downloadByDate" = false;
          # "mail.server.server_${id}.downloadUnreadOnly" = false;
          # "mail.server.server_${id}.login_at_startup" = true;
          # "mail.server.server_${id}.max_cached_connections" = 5;
          # "mail.server.server_${id}.moveOnSpam" = true;
          # "mail.server.server_${id}.moveTargetMode" = 1;
          # "mail.server.server_${id}.numHdrsToKeep" = 2000;
          # "mail.server.server_${id}.timeout" = 29;
          # "mail.server.server_${id}.type" = "imap";
        };
        perIdentitySettings_template = id: {
          # "mail.identity.id_${id}.archives_folder_picker_mode" = "1";
          # "mail.identity.id_${id}.attachPgpKey" = true;
          # "mail.identity.id_${id}.autoEncryptDrafts" = true;
          # "mail.identity.id_${id}.doBcc" = false;
          # "mail.identity.id_${id}.drafts_folder_picker_mode" = "0";
          # "mail.identity.id_${id}.e2etechpref" = 0;
          # "mail.identity.id_${id}.fcc_folder_picker_mode" = "0";
          # # "mail.identity.id_${id}.fullName" = "Sarah Vaupel";
          # "mail.identity.id_${id}.protectSubject" = true;
          # "mail.identity.id_${id}.reply_on_top" = 1;
          # "mail.identity.id_${id}.sendAutocryptHeaders" = true;
          # "mail.identity.id_${id}.showSaveMsgDlg" = false;
          # "mail.identity.id_${id}.sig_on_fwd" = true;
          # "mail.identity.id_${id}.tmpl_folder_picker_mode" = "0";
          # "mail.identity.id_${id}.valid" = true;
        };
      in
      {
        uniworx = {
          primary = true;
          address = "sarah.vaupel@uniworx.de";
          aliases = [ "savau@uniworx.de" ];
          userName = "savau";
          realName = "Sarah Vaupel";
          signature = {
            # TODO use command instead of text?
            text = ''
              Sarah Vaupel
              UniWorX Systems
              https://uniworx.de/

              E-Mail: sarah.vaupel@uniworx.de
              Tel.: +49 179 4130707
            '';
            showSignature = "append";
          };
          imap = {
            host = "imap.uniworx.de";
            port = 993;
            tls = {
              enable = true;
              useStartTls = false;
              certificatesFile = ./savau.crt;
            };
          };
          smtp = {
            host = "mailsub.uniworx.de";
            port = 465;
            tls = {
              enable = true;
              useStartTls = false;
              certificatesFile = ./savau.crt;
            };
          };
          folders = {
            inbox = "Inbox";
            sent = "Sent";
            drafts = "Drafts";
            trash = "Trash";
          };
          thunderbird = {
            enable = true;
            settings = id: (settings_template id) // {
              "mail.server.server_${id}.authMethod" = 7;
              "mail.server.server_${id}.check_time" = 5;
              # "mail.server.server_${id}.clientid" = "ee8a3766-602b-40c3-a227-b9d72d06cfdc";
              # "mail.server.server_${id}.directory" = "/home/savau/.thunderbird/default/ImapMail/imap.uniworx.de";
              # "mail.server.server_${id}.directory-rel" = "[ProfD]ImapMail/imap.uniworx.de";
              # "mail.server.server_${id}.hostname" = "imap.uniworx.de";
              # "mail.server.server_${id}.name" = "sarah.vaupel@uniworx.de";
              "mail.server.server_${id}.namespace.personal" = "\"\"";
              # "mail.server.server_${id}.port" = 993;
              # "mail.server.server_${id}.socketType" = 3;
              # "mail.server.server_${id}.spamActionTargetAccount" = "imap://savau@imap.uniworx.de";
              # "mail.server.server_${id}.spamActionTargetFolder" = "imap://savau@imap.uniworx.de/Junk";
              # "mail.server.server_${id}.userName" = "savau";
              "mail.smtpserver.smtp_uniworx.authMethod" = 1;
            };
            perIdentitySettings = id: (perIdentitySettings_template id) // {
              # "mail.identity.id_${id}.archive_folder" = "imap://savau@imap.uniworx.de/Archives";
              # "mail.identity.id_${id}.attach_signature" = false;
              # "mail.identity.id_${id}.attach_vcard" = false;
              # "mail.identity.id_${id}.catchAll" = false;
              # "mail.identity.id_${id}.draft_folder" = "imap://savau@imap.uniworx.de/Drafts";
              # "mail.identity.id_${id}.encryptionpolicy" = 0;
              # "mail.identity.id_${id}.fcc_folder" = "imap://savau@imap.uniworx.de/Sent";
              # "mail.identity.id_${id}.htmlSigFormat" = false;
              # "mail.identity.id_${id}.htmlSigText" = "Sarah Vaupel\nUniWorX Systems\nhttps://uniworx.de/\n\nE-Mail: sarah.vaupel@uniworx.de\nTel.: +49 179 4130707";
              # "mail.identity.id_${id}.is_gnupg_key_id" = true;
              # "mail.identity.id_${id}.sig_bottom" = true;
              # "mail.identity.id_${id}.sign_mail" = false;
              # "mail.identity.id_${id}.smtpServer" = "smtp_uniworx";
              # "mail.identity.id_${id}.stationery_folder" = "imap://savau@imap.uniworx.de/Templates";
              # "mail.identity.id_${id}.useremail" = "sarah.vaupel@uniworx.de";
            };
          };
        };
        # protonmail = {
        #   address = "sarah.vaupel@protonmail.com";
        #   aliases = [ "sarah.vaupel@proton.me" "sarah.vaupel@pm.me" ];
        #   realName = "Sarah Vaupel";
        #   userName = "sarah.vaupel@protonmail.com";
        #   imap = {
        #     host = "127.0.0.1";
        #     port = 1143;
        #     tls.enable = true;
        #     tls.useStartTls = true;
        #   };
        #   smtp = {
        #     host = "127.0.0.1";
        #     port = 1025;
        #     tls.enable = true;
        #     tls.useStartTls = true;
        #   };
        #   thunderbird = {
        #     enable = true;
        #     settings = id: (settings_template id) // {
        #       # "mail.server.server_${id}.clientid" = "217d2636-ed83-46e8-932d-7689e637169c";
        #       "mail.server.server_${id}.directory" = "/home/savau/.thunderbird/default/ImapMail/127.0.0.1";
        #       "mail.server.server_${id}.directory-rel" = "[ProfD]ImapMail/127.0.0.1";
        #       # "mail.server.server_${id}.hostname" = "127.0.0.1";
        #       # "mail.server.server_${id}.name" = "sarah.vaupel@protonmail.com";
        #       # "mail.server.server_${id}.port" = 1143;
        #       "mail.server.server_${id}.socketType" = 2;
        #       "mail.server.server_${id}.spamActionTargetAccount" = "imap://sarah.vaupel%40protonmail.com@127.0.0.1";
        #       "mail.server.server_${id}.spamActionTargetFolder" = "imap://sarah.vaupel%40protonmail.com@127.0.0.1/Spam";
        #       # "mail.server.server_${id}.userName" = "sarah.vaupel@protonmail.com";
        #     };
        #     perIdentitySettings = id: (perIdentitySettings_template id) // {
        #       "mail.identity.id_${id}.draft_folder" = "imap://sarah.vaupel%40protonmail.com@127.0.0.1/Drafts";
        #       "mail.identity.id_${id}.encryptionpolicy" = 2;
        #       "mail.identity.id_${id}.fcc_folder" = "imap://sarah.vaupel%40protonmail.com@127.0.0.1/Sent";
        #       "mail.identity.id_${id}.is_gnupg_key_id" = false;
        #       "mail.identity.id_${id}.openpgp_key_id" = "DB47DBFBE93A1EB4";
        #       "mail.identity.id_${id}.sign_mail" = true;
        #       "mail.identity.id_${id}.smtpServer" = "smtp_protonmail";
        #       "mail.identity.id_${id}.stationery_folder" = "imap://sarah.vaupel%40protonmail.com@127.0.0.1/Templates";
        #       # "mail.identity.id_${id}.useremail" = "sarah.vaupel@protonmail.com";
        #     };
        #   };
        # };
        # gmail = {
        #   address = "sarah.elisa.vaupel@gmail.com";
        #   flavor = "gmail.com";
        #   realName = "Sarah Vaupel";
        #   userName = "sarah.elisa.vaupel@gmail.com";
        #   imap = {
        #     host = "imap.gmail.com";
        #     port = 993;
        #     tls.enable = true;
        #     tls.useStartTls = false;
        #   };
        #   smtp = {
        #     host = "smtp.gmail.com";
        #     port = 465;
        #     tls.enable = true;
        #     tls.useStartTls = false;
        #   };
        #   thunderbird = {
        #     enable = true;
        #     settings = id: (settings_template id) // {
        #       # "mail.server.server_${id}.clientid" = "c418463c-7c41-4e81-bc57-7027b4c9564c";
        #       "mail.server.server_${id}.authMethod" = 10;
        #       "mail.server.server_${id}.directory" = "/home/savau/.thunderbird/default/ImapMail/imap.gmail.com";
        #       "mail.server.server_${id}.directory-rel" = "[ProfD]ImapMail/imap.gmail.com";
        #       # "mail.server.server_${id}.hostname" = "imap.gmail.com";
        #       "mail.server.server_${id}.is_gmail" = true;
        #       # "mail.server.server_${id}.name" = "sarah.elisa.vaupel@gmail.com";
        #       "mail.server.server_${id}.namespace.personal" = "\"\"";
        #       "mail.server.server_${id}.oauth2.issuer" = "accounts.google.com";
        #       "mail.server.server_${id}.oauth2.scope" = "https://mail.google.com/ https://www.googleapis.com/auth/carddav https://www.googleapis.com/auth/calendar";
        #       # "mail.server.server_${id}.port" = 993;
        #       "mail.server.server_${id}.socketType" = 3;
        #       "mail.server.server_${id}.spamActionTargetAccount" = "imap://sarah.elisa.vaupel%40gmail.com@imap.gmail.com";
        #       "mail.server.server_${id}.spamActionTargetFolder" = "imap://sarah.elisa.vaupel%40gmail.com@imap.gmail.com/[Gmail]/Spam";
        #       # "mail.server.server_${id}.userName" = "sarah.elisa.vaupel@gmail.com";
        #     };
        #     perIdentitySettings = id: (perIdentitySettings_template id) // {
        #       "mail.identity.id_${id}.archive_folder" = "imap://sarah.elisa.vaupel%40gmail.com@imap.gmail.com/Archives";
        #       "mail.identity.id_${id}.draft_folder" = "imap://sarah.elisa.vaupel%40gmail.com@imap.gmail.com/Drafts";
        #       "mail.identity.id_${id}.encryptionpolicy" = 0;
        #       "mail.identity.id_${id}.fcc_folder" = "imap://sarah.elisa.vaupel%40gmail.com@imap.gmail.com/Sent";
        #       "mail.identity.id_${id}.is_gnupg_key_id" = true;
        #       "mail.identity.id_${id}.sig_bottom" = true;
        #       "mail.identity.id_${id}.sign_mail" = false;
        #       "mail.identity.id_${id}.smtpServer" = "smtp_gmail";
        #       "mail.identity.id_${id}.stationery_folder" = "imap://sarah.elisa.vaupel%40gmail.com@imap.gmail.com/Templates";
        #       # "mail.identity.id_${id}.useremail" = "sarah.elisa.vaupel@gmail.com";
        #     };
        #   };
        # };
      };
  };
}
