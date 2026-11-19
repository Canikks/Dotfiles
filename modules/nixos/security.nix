{
  pkgs,
  lib,
  ...
}: {
  # --- Security ---
  security = {
    polkit = {
      enable = true;
      adminIdentities = ["unix-user:utkar" "unix-group:users"];
      extraConfig = "/* Log authorization checks. */\npolkit.addRule(function(action, subject) {\n  // Make sure to set { security.polkit.debug = true; } in configuration.nix\n  polkit.log(\"user \" +  subject.user + \" is attempting action \" + action.id + \" from PID \" + subject.pid);\n});\n";
    };
    tpm2 = {
      enable = true;
      abrmd.enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
      tctiEnvironment.interface = "tabrmd";
    };
    rtkit = {
      enable = true;
    };
    sudo-rs = {
      enable = lib.mkDefault true;
      configFile = ''
        username ALL=(root) NOPASSWD: /run/current-system/sw/bin/tlp, \
                              /run/current-system/sw/bin/tee /sys/firmware/acpi/platform_profile, \
                              /run/current-system/sw/bin/tee /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference, \
                              /run/current-system/sw/bin/tee /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference, \
                              /run/current-system/sw/bin/tee /sys/devices/system/cpu/cpu2/cpufreq/energy_performance_preference, \
                              /run/current-system/sw/bin/tee /sys/devices/system/cpu/cpu3/cpufreq/energy_performance_preference
      '';
    };
    pki = {
      certificateFiles = ["${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"];
    };
    # unprivilegedUsernsClone = true;
  };
}
