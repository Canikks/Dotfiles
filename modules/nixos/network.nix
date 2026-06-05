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

    nat = {
      enable = true;
      internalInterfaces = ["virbr0"];
    };

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
        networkmanager-fortisslvpn
        networkmanager-iodine
        networkmanager-l2tp
        networkmanager-openconnect
        networkmanager-openvpn
        networkmanager-sstp
        networkmanager-strongswan
        networkmanager-vpnc
      ];
    };

    # --- Firewall ---
    firewall = {
      enable = true;
      allowedTCPPorts = [
        8888
        8080
        8000
        53
      ];
      allowedUDPPorts = [
        53
        67
      ];
    };
  };
}
