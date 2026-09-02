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
    useSystemdActivation = true;

    secrets = {
      proton_wireguard_private_key = {
        key = "proton";
        owner = "root";
        group = "root";
        mode = "0400";
      };
      netrc = {
        key = "netrc";
        owner = "root";
        group = "root";
        mode = "0400";
      };
      hermes_env = {
        key = "hermes_env";
        owner = config.users.users.utkar.name;
        group = config.users.users.utkar.group;
        restartUnits = ["hermes-agent.service"];
      };
      searx_key = {
        key = "searx_key";
        owner = config.users.users.utkar.name;
        group = config.users.users.utkar.group;
        restartUnits = ["searx.service"];
      };
      github_token = {
        key = "github_token";
        owner = config.users.users.utkar.name;
        group = config.users.users.utkar.group;
      };
      Airtel_pass = {
        key = "Airtel_pass";
        owner = config.users.users.utkar.name;
        group = config.users.users.utkar.group;
      };
      gitlab_token = {
        key = "gitlab_token";
        owner = config.users.users.utkar.name;
        group = config.users.users.utkar.group;
      };
      forgejo_token = {
        key = "forgejo_token";
        owner = config.users.users.utkar.name;
        group = config.users.users.utkar.group;
      };
      ssh_id_ed25519 = {
        owner = config.users.users.utkar.name;
        group = config.users.users.utkar.group;
        mode = "0600";
      };
    };
  };
}
