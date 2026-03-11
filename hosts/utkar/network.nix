{...}: {
  networking = {
    networkmanager.enable = true;
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
      ];
    };
  };
}
