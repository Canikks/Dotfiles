{...}: {
  # --- System & Localization ---
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };
  location.provider = "geoclue2";

  # --- Swap & Zram ---
  swapDevices = [
    {
      device = "/dev/disk/by-label/nix-swap";
    }
  ];
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
