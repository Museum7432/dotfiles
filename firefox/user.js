// disable accessibility
user_pref("accessibility.force_disabled", 1);
// disable poket
user_pref("extensions.pocket.enabled", false);

user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// enable compact mode
user_pref("browser.compactmode.show", true);

user_pref("media.ffmpeg.vaapi.enabled", true);

user_pref("browser.tabs.tabMinWidth", 128);
// open previous session on start
user_pref("browser.startup.page", 3);

// user_pref("identity.fxaccounts.enabled", false);
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);

user_pref("browser.download.useDownloadDir", false);

// use ram cache
// replace 1000 with your user id
user_pref("browser.cache.disk.parent_directory", "/run/user/1000/firefox");


user_pref("browser.quitShortcut.disabled", true);


// Tracking protection
user_pref("privacy.trackingprotection.enabled", true);

user_pref("privacy.firstparty.isolate", true);
user_pref("privacy.resistFingerprinting", true);
// change user agent
// user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; rv:122.0) Gecko/20100101 Firefox/122.0");
// user_pref("general.platform.override", "Win32");

user_pref("toolkit.telemetry.enabled", false);
user_pref("webgl.disabled", true);

// disable WebAssembly
user_pref("javascript.options.wasm", false);
user_pref("javascript.options.wasm_baselinejit", false);
user_pref("javascript.options.wasm_ionjit", false);


// change how zoom with ctrl+scroll wheel works
user_pref("mousewheel.with_control.action", 5);
user_pref("mousewheel.with_alt.action", 3);


// mullvad SOCKS5 proxy
// user_pref("network.proxy.socks", "10.64.0.1");
// user_pref("network.proxy.socks_port", 1080);
// user_pref("network.proxy.socks_remote_dns", true);
// user_pref("network.proxy.socks_version", 5);
// user_pref("network.proxy.type", 1);

// user kde file picker instead of gtk (require xdg-desktop-portal-kde)
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

/****************************************************************************
 * SECTION: MAKE FIREFOX FAST                                               *
 * [NOTE] The following is not recommended for low-end machines             *
 * Credit for many of these:                                                *
 * https://gist.github.com/RubenKelevra/fd66c2f856d703260ecdf0379c4f59db    *
 * [NOTE] For best performance on older hardware, you will need to test     *
 * these settings individually.                                             *
 ****************************************************************************/

/****************************************************************************
 * SECTION: GFX RENDERING TWEAKS                                            *
 ****************************************************************************/

// PREF: Webrender tweaks
// [1] https://searchfox.org/mozilla-central/rev/6e6332bbd3dd6926acce3ce6d32664eab4f837e5/modules/libpref/init/StaticPrefList.yaml#6202-6219
// [2] https://hacks.mozilla.org/2017/10/the-whole-web-at-maximum-fps-how-webrender-gets-rid-of-jank/
// [3] https://www.troddit.com/r/firefox/comments/tbphok/is_setting_gfxwebrenderprecacheshaders_to_true/i0bxs2r/
// [4] https://www.troddit.com/r/firefox/comments/z5auzi/comment/ixw65gb?context=3
user_pref("gfx.webrender.all", true); // enables WR (GPU) + additional features
// user_pref("gfx.webrender.precache-shaders", true);
// user_pref("gfx.webrender.compositor", true);
// user_pref("gfx.webrender.compositor.force-enabled", true); // enforce
// user_pref("layers.gpu-process.enabled", true);
// user_pref("layers.gpu-process.force-enabled", true); // enforce
// user_pref("media.hardware-video-decoding.enabled", true);
// user_pref("media.hardware-video-decoding.force-enabled", true); // enforce

// PREF: disable AV1 for hardware decodeable videos
// AV1 uses software (CPU-based) decoding
// Firefox sometimes uses AV1 video decoding even to GPUs which do not support it
// [1] https://www.troddit.com/r/AV1/comments/s5xyph/youtube_av1_codec_have_worse_quality_than_old_vp9
user_pref("media.av1.enabled", false);

/****************************************************************************
 * SECTION: BROWSER CACHE                                                   *
 ****************************************************************************/

// PREF: increase memory cache size
// [1] https://www.makeuseof.com/tag/how-much-data-does-youtube-use/
//user_pref("browser.cache.memory.capacity", -1); // DEFAULT; 256000=256MB, 512000=512MB, 1024000=1GB, 2097152=2GB, 5242880=5GB, 8388608=8GB
user_pref("browser.cache.memory.max_entry_size", -1); // alt=51200; preferred=327680 ; alt= -1 -> entries bigger than than 90% of the mem-cache are never cached
