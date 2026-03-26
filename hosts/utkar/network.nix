{pkgs, ...}: {
  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["virbr0"];
    };
    networkmanager.enable = true;
    # networkmanager.dhcp = "dhcpcd";
    # networkmanager.wifi.backend = "iwd";
    networkmanager.plugins = with pkgs; [
      networkmanager-fortisslvpn
      networkmanager-iodine
      networkmanager-l2tp
      networkmanager-openconnect
      networkmanager-openvpn
      networkmanager-sstp
      networkmanager-strongswan
      networkmanager-vpnc
    ];
    hostName = "utkar";
    networkmanager.dns = "none";
    nameservers = ["127.0.0.1" "::1"];
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
