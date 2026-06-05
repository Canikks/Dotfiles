{config, ...}: {
  # --- Secrets (SOPS) ---
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    useTmpfs = true;
    age.keyFile = "${config.users.users.utkar.home}/.config/sops/age/keys.txt";
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    # age.generateKey = true;
    useSystemdActivation = true;

    secrets.netrc = {
      key = "netrc";
      owner = "root";
      group = "root";
      mode = "0400";
    };
    secrets.hermes_env = {
      key = "hermes_env";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
      restartUnits = ["hermes-agent.service"];
    };
    secrets.searx_key = {
      key = "searx_key";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
      restartUnits = ["searx.service"];
    };
    secrets.github_token = {
      key = "github_token";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
    };
    secrets.Airtel_pass = {
      key = "Airtel_pass";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
    };
    secrets.gitlab_token = {
      key = "gitlab_token";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
    };
    secrets.forgejo_token = {
      key = "forgejo_token";
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
    };
    secrets.ssh_id_ed25519 = {
      owner = config.users.users.utkar.name;
      group = config.users.users.utkar.group;
      mode = "0600";
    };
  };
}
