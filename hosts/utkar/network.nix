{pkgs, ...}: {
  networking = {
    # --- General Settings ---
    hostName = "utkar";
    usePredictableInterfaceNames = true;
    nameservers = ["127.0.0.1" "::1"];

    nat = {
      enable = true;
      internalInterfaces = ["virbr0"];
    };

    # --- NetworkManager ---
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.backend = "iwd";
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
