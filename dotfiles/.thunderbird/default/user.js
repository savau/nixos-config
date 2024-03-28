// Theme and color settings
user_pref("browser.display.background_color", "#1e1e1e");
user_pref("browser.display.foreground_color", "#ffffff");
user_pref("browser.display.use_system_colors", false);
user_pref("browser.anchor_color", "#62a0ea");
user_pref("browser.visited_color", "#dc8add");
user_pref("browser.underline_anchors", false);
user_pref("msgcompose.background_color", "#1e1e1e");
user_pref("msgcompose.text_color", "#ffffff");
user_pref("msgcompose.default_colors", false);

// Font settings
user_pref("browser.display.use_document_fonts", 1);
user_pref("font.name.monospace.x-western", "Liberation Mono");
user_pref("font.name.sans-serif.x-western", "Liberation Sans");
user_pref("font.name.serif.x-western", "Liberation Serif");

// Date and time overrides
user_pref("intl.date_time.pattern_override.date_full", "yyyy-MM-dd");
user_pref("intl.date_time.pattern_override.date_long", "yyyy-MM-dd");
user_pref("intl.date_time.pattern_override.date_medium", "yyyy-MM-dd");
user_pref("intl.date_time.pattern_override.date_short", "yyyy-MM-dd");
user_pref("intl.date_time.pattern_override.connector_short", " ");
user_pref("intl.date_time.pattern_override.time_full", "HH:mm");
user_pref("intl.date_time.pattern_override.time_long", "HH:mm");
user_pref("intl.date_time.pattern_override.time_medium", "HH:mm");
user_pref("intl.date_time.pattern_override.time_short", "HH:mm");

// Mail composition settings
user_pref("mail.html_compose", false);
user_pref("mail.identity.default.compose_html", false);
user_pref("msgcompose.font_face", "monospace");
user_pref("mail.compose.default_to_paragraph", false);
user_pref("mail.compose.big_attachments.notify", false);

// Mail display settings
user_pref("mail.strict_threading", true);
user_pref("mail.inline_attachments", true);
user_pref("mailnews.display.html_as", 1);
user_pref("mailnews.display.prefer_plaintext", true);
user_pref("mailnews.headers.showSender", true);
user_pref("mailnews.headers.showUserAgent", true);
user_pref("mailnews.headers.sendUserAgent", false);

// Calendar settings
user_pref("calendar.alarms.playsound", true);
user_pref("calendar.alarms.show", true);
user_pref("calendar.alarms.showmissed", false);
user_pref("calendar.view.dayendhour", 22);
user_pref("calendar.view.showLocation", true);

// RSS feed settings
user_pref("rss.display.disallow_mime_handlers", 3);
user_pref("rss.display.html_as", 1);
user_pref("rss.display.prefer_plaintext", true);
user_pref("rss.show.content-base", 1);

// Privacy and security settings
user_pref("accessibility.typeaheadfind.autostart", false);
user_pref("accessibility.typeaheadfind.prefillwithselection", false);
user_pref("beacon.enabled", false);
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.offline.enable", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
// user_pref("browser.chrome.site_icons", false);
user_pref("browser.chrome.favicons", false);
user_pref("browser.formfill.enable", false);
user_pref("browser.region.update.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.block_dangerous", false);
user_pref("browser.safebrowsing.downloads.remote.block_dangerous_host", false);
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.downloads.remote.url", "https://s.%.c.invalid/download?key=leer");
user_pref("browser.search.update", false);
user_pref("browser.search.suggest.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_send_http_background_request", false);
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.ui.lastCategory", "addons://list/extension");
user_pref("javascript.options.baselinejit", false);
user_pref("javascript.options.ion", false);
user_pref("javascript.options.native_regexp", false);
user_pref("mail.openpgp.allow_external_gnupg", true);
user_pref("mail.purge.ask", false);
user_pref("mail.showCondensedAddresses", false);
user_pref("mail.smtpserver.default.hello_argument", "[127.0.0.1]");
user_pref("mail.startup.enabledMailCheckOnce", true);
user_pref("mailnews.auto_config.fetchFromExchange.enabled", false);
user_pref("mailnews.auto_config.fetchFromISP.sendEmailAddress", false);
user_pref("mailnews.auto_config.fetchFromISP.sslOnly", true);
user_pref("mailnews.auto_config.guess.sslOnly", true);
user_pref("mailnews.start_page.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("network.connectivity-service.enabled", false);
user_pref("network.cookie.cookieBehavior", 2);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.IDN_show_punycode", true);
user_pref("network.http.sendRefererHeader", 0);
user_pref("network.prefetch-next", 0);
user_pref("pdfjs.disabled", true);
user_pref("pdfjs.enableScripting", false);
user_pref("places.history.enabled", false);
user_pref("privacy.donottrackheader.enabled", false);
user_pref("privacy.trackingprotection.enabled", false);
user_pref("security.family_safety.mode", 0);
user_pref("security.cert_pinning.enforcement_level", 2);
user_pref("security.mixed_content.upgrade_display_content", 2);
user_pref("security.mixed_content.block_object_subrequest", 2);
user_pref("security.OCSP.enabled", 0);
user_pref("security.ssl.require_safe_negotiation", true);
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("security.ssl3.ecdhe_ecdsa_aes_128_sha", false);
user_pref("security.ssl3.ecdhe_ecdsa_aes_256_sha", false);
user_pref("security.ssl3.ecdhe_rsa_aes_128_sha", false);
user_pref("security.ssl3.ecdhe_rsa_aes_256_sha", false);
user_pref("security.tls.enable_0rtt_data", false);
user_pref("services.settings.server", "https://s.%.c.invalid/v1");
