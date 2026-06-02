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
      debug = true;
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
      enable = true;
    };
    pki = {
      certificateFiles = ["${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"];
    };
    unprivilegedUsernsClone = true;
  };
}
