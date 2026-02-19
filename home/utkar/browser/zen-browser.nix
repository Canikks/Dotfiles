{
  pkgs,
  # inputs,
  ...
}: {
  imports = [
    ./zen-stuff/extensions.nix
    ./zen-stuff/mods.nix
    ./zen-stuff/pref.nix
  ];
  programs.zen-browser = {
    enable = true;
    suppressXdgMigrationWarning = true;
    profiles = {
      "Dw3oaFqL.Profile 1" = {
        id = 0;
        isDefault = true;
        sine.enable = true;
        # sine.mods = [
        #   "advanced-tab-groups"
        #   "Arc-2.0"
        #   "context-menu-icons"
        #   "quick-search-zen-browser"
        #   "zen-tidy-tabs"
        #   "reopen-closed-tabs"
        #   "zen-command-palette"
        #   "new-icons"
        #   "auto-pip-setting"
        #   "settings-shortcuts-search"
        #   "Custom Swipe Animation & Color"
        #   "bubble-pop-deleting"
        #   "quick-tabs"
        #   "floating-findbar"
        #   "compact-settings"
        #   "unloaded-tabs"
        # ];
        # extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        #   darkreader
        #   ublock-origin
        #   keepassxc-browser
        #   zen-internet
        #   localcdn
        #   enhanced-h264ify
        #   sponsorblock
        # ];
        # settings = {
        #   "browser.sessionstore.interval" = 300000;
        #   "browser.sessionstore.max_tabs_undo" = 5;
        #   "browser.sessionstore.max_windows_undo" = 3;
        #   "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
        #   "browser.tabs.unloadOnLowMemory" = true;
        #   "browser.low_commit_space_threshold_mb" = 512;
        #   "browser.tabs.min_inactive_duration_before_unload" = 600000;
        #   "browser.tabs.warnOnClose" = false;
        #   "browser.tabs.warnOnCloseOtherTabs" = false;
        #   "dom.ipc.processCount" = 6;
        #   "dom.ipc.processCount.webIsolated" = 2;
        #   "dom.ipc.keepProcessesAlive.web" = 1;
        #   "dom.ipc.processCount.extension" = 1;
        #   "media.hardware-video-decoding.enabled" = true;
        #   "media.ffmpeg.vaapi.enabled" = true;
        #   "gfx.webrender.all" = true;
        #   "gfx.webrender.compositor" = true;
        #   "gfx.webrender.max-partial-preset-rects" = 1;
        #   "layers.acceleration.force-enabled" = true;
        #   "media.av1.enabled" = true;
        #   "media.rdd-vpx.enabled" = true;
        #   "layout.frame-rate.precise" = true;
        #   "network.http.max-connections" = 900;
        #   "network.http.max-persistent-connections-per-server" = 10;
        #   "network.http.pacing.requests.enabled" = true;
        #   "network.dnsCacheExpiration" = 3600;
        #   "network.prefetch-next" = false;
        #   "network.predictor.enabled" = false;
        #   "network.predictor.enable-prefetch" = false;
        #   "apz.overscroll.enabled" = true;
        #   "general.smoothScroll" = true;
        #   "mousewheel.default.delta_multiplier_y" = 275;
        #   "datareporting.healthreport.uploadEnabled" = false;
        #   "datareporting.policy.dataSubmissionEnabled" = false;
        #   "toolkit.telemetry.enabled" = false;
        #   "toolkit.telemetry.unified" = false;
        #   "toolkit.telemetry.server" = "";
        #   "app.shield.optoutstudies.enabled" = false;
        #   "browser.discovery.enabled" = false;
        #   "browser.aboutConfig.showWarning" = false;
        #   "privacy.trackingprotection.enabled" = true;
        #   "privacy.trackingprotection.socialtracking.enabled" = true;
        #   "privacy.partition.network_state" = true;
        #   "privacy.partition.serviceWorkers" = true;
        #   "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
        #   "media.peerconnection.ice.default_address_only" = true;
        #   "media.peerconnection.ice.no_host" = true;
        #   "dom.timeout.background_throttling_max_budget" = 10000;
        #   "dom.min_background_timeout_value" = 1000;
        #   "dom.ipc.processPriorityManager.backgroundUsesEcoQoS" = true;
        #   "dom.events.asyncClipboard" = true;
        #   "security.ssl.require_safe_negotiation" = true;
        #   "security.tls.enable_0rtt_data" = false;
        #   "security.remote_settings.crlite_filters.enabled" = true;
        #   "security.remote_settings.intermediates.enabled" = true;
        #   "browser.cache.disk.enable" = true;
        #   "browser.cache.disk.smart_size.enabled" = true;
        #   "browser.cache.disk.metadata_memory_limit" = 512;
        #   "browser.cache.memory.enable" = true;
        #   "browser.ml.enable" = true;
        #   "browser.ml.chat.enabled" = false;
        # };
      };
    };
    nativeMessagingHosts = [pkgs.firefoxpwa];
  };
}
