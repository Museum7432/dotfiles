// disable accessibility
user_pref("accessibility.force_disabled", 1);

// user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// enable compact mode
// user_pref("browser.compactmode.show", true);

// user_pref("media.ffmpeg.vaapi.enabled", true);

// user_pref("browser.tabs.tabMinWidth", 128);
// open previous session on start
user_pref("browser.startup.page", 3);

// user_pref("identity.fxaccounts.enabled", false);
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);
user_pref("browser.download.useDownloadDir", false);

// use ram cache
// replace 1000 with your user id
// user_pref("browser.cache.disk.parent_directory", "/run/user/1000/firefox");

user_pref("browser.quitShortcut.disabled", true);

// change how zoom with ctrl+scroll wheel works
user_pref("mousewheel.with_control.action", 5);
user_pref("mousewheel.with_alt.action", 3);

// use kde file picker instead of gtk (require xdg-desktop-portal-kde)
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
user_pref("widget.use-xdg-desktop-portal.mime-handler", 1);

/**************************************************
 * SOURCE: https://github.com/yokoffing/Betterfox *
 **************************************************/

// PREF: initial paint delay
// How long FF will wait before rendering the page, in milliseconds
// Reduce the 5ms Firefox waits to render the page
// [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1283302
// [2] https://docs.google.com/document/d/1BvCoZzk2_rNZx3u9ESPoFjSADRI0zIPeJRXFLwWXx_4/edit#heading=h.28ki6m8dg30z
user_pref("nglayout.initialpaint.delay", 0); // default=5; used to be 250
user_pref("nglayout.initialpaint.delay_in_oopif", 0); // default=5

// PREF: disable AV1 for hardware decodeable videos
// AV1 uses software (CPU-based) decoding
// Firefox sometimes uses AV1 video decoding even to GPUs which do not support it
// [1] https://www.troddit.com/r/AV1/comments/s5xyph/youtube_av1_codec_have_worse_quality_than_old_vp9
user_pref("media.av1.enabled", false);

user_pref("browser.contentblocking.category", "strict");
