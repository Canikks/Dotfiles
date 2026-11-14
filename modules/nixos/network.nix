{
  config,
  pkgs,
  lib,
  ...
}: {
  networking = {
    # --- General Settings ---
    useDHCP = false;
    hostName = "utkar";
    usePredictableInterfaceNames = lib.mkDefault true;
    nameservers = ["127.0.0.1"];
    nftables.enable = true;

    nat = {
      enable = false;
      # internalInterfaces = ["virbr0"];
      # externalInterface = "proton";
    };

    # wg-quick.interfaces.proton = {
    #   privateKeyFile = config.sops.secrets.proton_wireguard_private_key.path;

    #   address = [
    #     "10.2.0.2/32"
    #     "2a07:b944::2:2/128"
    #   ];

    #   dns = [
    #     "10.2.0.1"
    #     "2a07:b944::2:1"
    #   ];

    #   peers = [
    #     {
    #       publicKey = "msLecK3aleRQCD0sfE3c7J5LlX0s2p3y5fp1BTUgczs=";
    #       allowedIPs = ["0.0.0.0/0" "::/0"];
    #       endpoint = "37.19.205.150:51820";
    #       persistentKeepalive = 25;
    #     }
    #   ];
    # };

    # --- NetworkManager ---
    networkmanager = {
      ensureProfiles = {
        profiles = {
          Airtel_mura_5G = {
            connection = {
              autoconnect-priority = "100";
              id = "Airtel_mura_5G";
              timestamp = "1776602870";
              type = "wifi";
              uuid = "fcd4dba9-28ac-411f-b0f4-36048a70ba5a";
            };
            ipv4 = {
              address1 = "192.168.1.100/24";
              dns = "127.0.0.1;";
              gateway = "192.168.1.1";
              may-fail = "false";
              method = "manual";
              route-metric = "100";
            };
            ipv6 = {
              addr-gen-mode = "default";
              method = "auto";
              route-metric = "100";
            };
            proxy = {};
            wifi = {
              mode = "infrastructure";
              ssid = "Airtel_mura_5G";
            };
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "${builtins.readFile config.sops.secrets.Airtel_pass.path}";
            };
          };
        };
      };
      enable = true;
      dns = "none";
      wifi.backend = "iwd";
      wifi.powersave = false;
      plugins = with pkgs; [
        networkmanager-iodine
        networkmanager-l2tp
        networkmanager-openconnect
        networkmanager-openvpn
        networkmanager-strongswan
        networkmanager-libreswan
      ];
    };

    # --- Firewall ---
    firewall = {
      enable = true;
      trustedInterfaces = ["tailscale0" "virbr0"];
      allowedTCPPorts = [
        8888
        8080
        8000
        53
        51820
        25565
      ];
      allowedUDPPorts = [
        53
        67
      ];
    };
  };
}
